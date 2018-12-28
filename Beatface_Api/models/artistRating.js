'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var artistRating = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        }

    };

    return sequelize.define('artistRating', artistRating);
};