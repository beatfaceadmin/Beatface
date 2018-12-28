'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var artist = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        availbility: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        area: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
    };

    return sequelize.define('artist', artist);
};