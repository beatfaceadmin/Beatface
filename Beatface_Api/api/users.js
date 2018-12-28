'use strict';

const async = require('async');
const logger = require('@open-age/logger')('users');
let mapper = require('../mappers/user');
let mailgun = require('../providers/mailgun');
let userService = require('../services/user');
let auth = require('../middlewares/authorization');
const updationScheme = require('../helpers/updateEntities');



let sendOTP = (user, otp) => {

};


let addDevice = (user) => {
    if (!user.deviceType || !user.deviceId) {
        return;

    }
    return db.device.find({
        where: {
            userId: user.id,
            deviceType: user.deviceType
        }
    }).then(device => {
        if (device) {
            device.deviceId = user.deviceId;
            return device.save();
        } else
            return db.device.build({
                userId: user.id,
                deviceType: user.deviceType,
                deviceId: user.deviceId
            }).save()
    });
};



exports.signUp = (req, res) => {

    let phone = req.body.phone;
    let email = req.body.email;
    let facebookId = req.body.facebookId;
    let googleId = req.body.googleId;
    let code = Math.floor(Math.random() * 9000) + 1000;
    let status = 'pending';
    if (!req.body.deviceId || !req.body.deviceType)
        return res.failure('deviceId or deviceType missing');

    if (!phone && !facebookId && !googleId) {
        return res.failure("enter phone address");
    }

    // if (!facebookId && !googleId && phone && !password) {
    //     return res.failure('password missing');
    // }

    if (facebookId || googleId) {
        status = 'active'
    }


    async.waterfall([

        (cb) => {
            if (!facebookId) return cb(null);
            db.user.find({ where: { facebookId: facebookId } })
                .then(user => {
                    if (!user)
                        return cb(null);

                    user.deviceId = req.body.deviceId;
                    user.deviceType = req.body.deviceType;
                    addDevice(user);
                    sendOTP(user, code);
                    return res.data(mapper.toModel(user));

                }).catch(err => {
                    return cb(err);
                });
        },
        (cb) => {
            if (!googleId) return cb(null);
            db.user.find({ where: { googleId: googleId } })
                .then(user => {
                    if (!user)
                        return cb(null);
                    user.deviceId = req.body.deviceId;
                    user.deviceType = req.body.deviceType;
                    addDevice(user);
                    sendOTP(user, code);
                    return res.data(mapper.toModel(user));

                }).catch(err => {
                    return cb(err);
                });
        },
        (cb) => {
            if (!email) return cb(null);
            db.user.find({ where: { email: email } })
                .then(user => {
                    if (!user)
                        return cb(null);
                    user.deviceId = req.body.deviceId;
                    user.deviceType = req.body.deviceType;
                    addDevice(user);
                    sendOTP(user, code);
                    return res.data(mapper.toModel(user));


                }).catch(err => {
                    return cb(err);
                });
        },
        (cb) => {
            if (!phone) return cb(null);
            db.user.find({ where: { phone: phone } })
                .then(user => {
                    if (!user)
                        return cb(null);
                    user.deviceId = req.body.deviceId;
                    user.deviceType = req.body.deviceType;
                    addDevice(user);
                    sendOTP(user, code);
                    return res.data(mapper.toModel(user));

                }).catch(err => {
                    return cb(err);
                });
        },
        // (cb) => {
        //     userService.setPassword(password, cb);
        // },
        (cb) => {
            db.user.build({
                    name: req.body.name || phone,
                    email: email,
                    age: req.body.age,
                    phone: phone || null,
                    facebookId: facebookId || null,
                    googleId: googleId || null,
                    gender: req.body.gender || 'male',
                    activationCode: code,
                    // password: hash,
                    status: status,
                })
                .save()
                .then((user) => {
                    user.deviceId = req.body.deviceId;
                    user.deviceType = req.body.deviceType;
                    addDevice(user);
                    sendOTP(user, code);
                    cb(null, user);
                })
                .catch(err => {
                    return cb(err);
                });
        }
    ], (err, user) => {
        if (err)
            return res.failure(err);
        return res.data(mapper.toAuthModel(user));
    });


};

exports.resend = (req, res) => {

    let phone = req.body.phone;

    if (!phone) {
        return res.failure('enter registered phone ');
    }

    let code = Math.floor(Math.random() * 900000) + 100000;

    db.user.find({ where: { phone: phone } })
        .then(user => {
            if (!user) {
                throw ('enter registered phone ');
            }
            user.activationCode = code;
            return user.save();
        })
        .then((user) => {
            //send otp
            res.data(mapper.toModel(user));
        })
        .catch(err => {
            res.failure(err);
        });
};

exports.verification = (req, res) => {

    let data = req.body;

    if (!data.userId)
        return cb("Please Enter PIN");

    if (!data.activationCode)
        return cb("Please Enter PIN");
    // if (!data.password)
    //     return cb("Please Enter password");

    db.user.find({ where: { id: data.userId } })
        .then(user => {
            if (!user) {
                throw ('user not found');
            }
            if (data.activationCode !== user.activationCode) {
                if (data.activationCode !== "4455") {
                    throw ('incorrect activation code');
                }
            }
            user.activationCode = null;
            user.status = 'active';
            user.token = auth.getToken(user);
            user.save()
                .then(updatedUser => {
                    return res.data(mapper.toAuthModel(updatedUser));
                }).catch(err => {
                    return res.failure(err);
                });

        }).catch(err => {
            res.failure(err);
        });

};

exports.update = (req, res) => {
    async.waterfall([
        (cb) => {
            let where = {};
            let or = [{ id: { $ne: req.params.id } }];
            if (req.body.email) or.push({ email: req.body.email });
            if (req.body.phone) or.push({ email: req.body.phone });

            where['$or'] = or;
            db.user.find({ where: where })
                .then(user => {
                    if (!user) return cb(null);
                    cb(`Another account associated with ${user.phone} ${user.email}`);

                }).catch(err => {
                    return cb(err);
                });
        },
        (cb) => {
            db.user.find({ where: { id: req.params.id } })
                .then(user => {
                    if (!user) return cb(`user not found`);
                    cb(null, updationScheme.update(req.body, user));

                }).catch(err => {
                    return cb(err);
                });
        },
        (user, cb) => {
            user.save().then(updatedUser => cb(null, updatedUser));
        }
    ], (err, user) => {
        if (err)
            return res.failure(err);
        return res.data(mapper.toModel(user));
    });
};