'use strict';
const fs = require('fs');
const path = require('path');
const basename = path.basename(module.filename);
const lodash = require('lodash');

let initModels = () => {
    let db = {};
    fs.readdirSync(__dirname)
        .filter((file) => {
            return (file.indexOf('.') !== 0) && (file !== basename);
        })
        .forEach((file) => {
            let model = sequelize['import'](path.join(__dirname, file));
            db[model.name] = model;
        });



    db.user.hasMany(db.device);
    db.device.belongsTo(db.user);

    db.user.hasOne(db.artist);
    db.artist.belongsTo(db.user);

    db.artist.hasMany(db.offer);
    db.offer.belongsTo(db.artist);

    db.artist.hasMany(db.service);
    db.service.belongsTo(db.artist);

    db.user.hasMany(db.artistRating);
    db.artistRating.belongsTo(db.user);
    db.artist.hasMany(db.artistRating);
    db.artistRating.belongsTo(db.artist);

    // db.IdentityType.hasMany(db.VendorTicket);
    // db.VendorTicket.belongsTo(db.IdentityType, {foreignKey: {allowNull: true}});

    // db.VendorTicket.hasMany(db.VendorPayment);
    // db.VendorPayment.belongsTo(db.VendorTicket, {foreignKey: {allowNull: true}});

    Object.keys(db).forEach((modelName) => {
        if ('associate' in db[modelName]) {
            db[modelName].associate(db);
        }
    });
    return db;
};


module.exports = initModels();