'usee strict';
const _ = require('underscore');

exports.toModel = (entity) => {
    const model = {
        id: entity.id,
        name: entity.name,
        status: entity.status,
        email: entity.email,
        phone: entity.phone,
        picUrl: entity.picUrl,
        picData: entity.picData,
        gender: entity.gender,
        age: entity.age
    };
    return model;
}

exports.toSearchModel = entities => {
    return _.map(entities, exports.toModel);
};


exports.toAuthModel = entity => {
    let model = exports.toModel(entity);
    model.token = entity.token;
    return model;
}