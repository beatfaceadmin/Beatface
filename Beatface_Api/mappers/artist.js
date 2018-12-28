'usee strict';
const _ = require('underscore');

exports.toModel = (entity) => {
    const model = {
        id: entity.id,
        availbility: entity.availbility,
        area: entity.area,
        services: entity.services,
        offers: []
    };

    if (entity.services) {
        _.forEach(entity.services, service => {
            validTill: service.validTill
            description: service.description
            offeredRate: service.offeredRate
            offeredRate: service.offeredRate
        })
    }
    return model;
}

exports.toSearchModel = entities => {
    return _.map(entities, exports.toModel);
};