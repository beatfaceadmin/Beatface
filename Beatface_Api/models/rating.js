'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var rating = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        value: {
            type: Sequelize.INTEGER,
            allowNull: false,
            validate: { min: 1, max: 5 }
        },
        comment: { type: Sequelize.STRING, allowNull: true, defaultValue: null },

    };

    return sequelize.define('artist', rating);
};