'use strict';
// var bcrypt = require('bcrypt-nodejs');
var bcrypt = require('bcrypt');

module.exports = () => {
    var user = {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        activationCode: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        name: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        age: { type: Sequelize.INTEGER, allowNull: true, defaultValue: null },
        email: {
            type: Sequelize.STRING,
            allowNull: true,
            defaultValue: null,
            unique: true
        },
        // password: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        token: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        phone: {
            type: Sequelize.STRING,
            allowNull: true,
            defaultValue: null,
            unique: true
        },
        picUrl: { type: Sequelize.STRING, allowNull: true, defaultValue: null },
        picData: { type: Sequelize.TEXT, allowNull: true, defaultValue: null },
        facebookId: { type: Sequelize.STRING, allowNull: true, defaultValue: null, unique: true },
        googleId: { type: Sequelize.STRING, allowNull: true, defaultValue: null, unique: true },
        status: {
            type: Sequelize.ENUM,
            values: ['pending', 'active', 'inactive'], //will b more
            defaultValue: 'pending'
        },
        gender: {
            type: Sequelize.ENUM,
            values: ['male', 'female', 'other'], //will b more
            allowNull: true,
            defaultValue: 'male'
        }

    };

    return sequelize.define('user', user);
};