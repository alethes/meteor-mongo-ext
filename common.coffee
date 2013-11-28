_.extend Meteor.Collection::,
    count: (query = {}) ->
        @find(query).count()
    save: (doc) ->
        if '_id' of doc
            id = doc._id
            delete doc._id
            @upsert id, $set: doc
        else
            @insert doc