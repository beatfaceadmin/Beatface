'use strict';

const fs = require('fs');
// const apiRoutes = require('@open-age/express-api');
const apiRoutes = require('../helpers/apiRoute');
const loggerConfig = require('config').get('logger');
var auth = require('../middlewares/authorization');


module.exports.configure = (app) => {

    app.get('/', (req, res) => {
        res.render('index', {
            title: 'BEATFACE API'
        });
    });
    app.get('/api', (req, res) => {
        res.render('index', {
            title: 'BEATFACE API'
        });
    });


    let api = apiRoutes(app);
    api.model('users')
        .register([{
            action: 'POST',
            method: 'signUp',
            url: '/signup',
        }, {
            action: 'POST',
            method: 'verification',
            url: '/verify'
        }, {
            action: 'POST',
            method: 'resend',
            url: '/resend'
        }, {
            action: 'POST',
            method: 'update',
            url: '/:id',
            filter: auth.requiresToken
        }]);
    // api.model('coupons')
    //     .register('REST', auth.requiresToken);
    // api.model('coupons')
    //     .register([{
    //         action: 'GET',
    //         method: 'used',
    //         url: '/history/used',
    //         filter: auth.requiresToken
    //     }]);

    // api.model({ path: '', controller: '' })
    //     .register([{
    //         action: 'GET',
    //         method: 'used',
    //         url: '/history/used',
    //         filter: auth.requiresToken
    //     }]);
}