'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var offer = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        description: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        validTill: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        originalRate: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        offeredRate: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
    };

    return sequelize.define('offer', offer);
};