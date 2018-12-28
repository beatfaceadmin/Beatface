'use strict';

const async = require('async');
const logger = require('@open-age/logger')('artist');
const mapper = require('../mappers/artist');
const updationScheme = require('../helpers/updateEntities');



exports.create = (req, res) => {
    let model = req.body;
    async.waterfall([
        cb => {
            db.artist.build({
                availbility: model.availbility,
                area: model.area,
                userId: req.user.id
            }).save().then(artist => cb(artist));
        },
        (artist, cb) => {
            if (!model.offer) return cb(null, artist);

            db.offer.build({
                description: model.offer.description || null,
                validTill: model.offer.validTill || null,
                originalRate: model.offer.originalRate || null,
                offeredRate: model.offer.offeredRate || null,
                artistId: artist.id
            }).save().then(offer => {
                artist.offer = offer;
                cb(null, artist)
            });

        }
    ], (err, artist) => {
        if (err) {
            return res.failure(err);
        }
        res.data(mapper.toModel(artist));
    })

};

exports.update = (req, res) => {
    let data = req.body;
    async.waterfall([
        cb => {
            db.artist.find({
                    where: { id: req.params.id },
                    include: [db.offer]
                })
                .then(artist => {
                    if (!artist) {
                        return cb('artist not found');
                    }
                    cb(null, updationScheme.update(data, artist));
                });
        }, (artist, cb) => {
            artist.save()
                .then(artist => {
                    if (artist.offers) {
                        // artist.offers[0].
                    } else
                        cb(null, artist)
                });
        }
    ], (err, coupon) => {
        if (err) {
            return res.failure(err);
        }
        res.data(mapper.toModel(coupon));
    });
};

exports.get = (req, res) => {
    db.artist.find({
            where: { id: req.params.id },
            include: [db.offer]
        })
        .then((artist) => {
            if (!artist) return res.failure('no artist found');
            return res.data(mapper.toModel(artist));
        })
        .catch((err) => res.failure(err))

};

exports.search = (req, res) => {

    let pageNo = req.query.pageNo ? Number(req.query.pageNo) : 1;
    let serverPaging = req.query.serverPaging == "false" ? false : true;
    let pageSize = req.query.pageSize ? Number(req.query.pageSize) : 10;
    let offset = pageSize * (pageNo - 1);
    let totalRecords = 0;

    let query = {
        order: [
            ['id', 'DESC']
        ]
    };

    if (serverPaging) {
        query.limit = pageSize;
        query.offset = offset;
    }

    let where = {};

    if (req.query.lastModifiedDate) {
        where.updatedAt = {
            $gte: Date.parse(req.query.lastModifiedDate)
        };
    }
    query.where = where;
    db.artist.findAll(query).then(artists => {
            db.artist.findAndCountAll({ where: where }).then(result => {
                    return res.page(mapper.toSearchModel(artists), pageNo, pageSize, result.count);
                })
                .catch(err => {
                    res.failure(err);
                });
        })
        .catch(err => {
            res.failure(err);
        });
};