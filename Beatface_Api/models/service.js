'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var service = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        estimatedTime: { type: Sequelize.DATE, allowNull: true, defaultValue: null },
        charges: { type: Sequelize.FLOAT, allowNull: true, defaultValue: null },
    };

    return sequelize.define('service', service);
};