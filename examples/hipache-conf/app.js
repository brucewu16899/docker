#!/usr/bin/env node

// export-issues.js
//------------------------------
//
// 2013-07-19, Jonas Colmsjö
//
// Copyright Gizur AB 2013
//
// Connecting 
//
// dependencies: npm install jsdom xmlhttprequest jQuery optimist
//
// Using Google JavaScript Style Guide - http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml
//
//------------------------------



(function(){

// Includes
// ================

var $       = require('jQuery');
var helpers = require('./helpers-old.js');
var argv    = require('optimist')
                .usage('Usage: ./app.js --cmd [command to run]')
                .demand(['cmd'])
                .argv;


// set logging level
helpers.logging.threshold  = helpers.logging.warn;


// Globals
//==============

var sep    = ';';
var oauthToken;


// Functions
//==============


// getOauthToken
//-------------------------------------------------------------------------------------------------
//
// Equivalent of: curl -i -u colmsjo -d '{"scopes":["repo"]}' https://api.github.com/authorizations
//

function getOauthToken(user, password){

    helpers.logDebug('getOauthToken: Starting list authorization...');

      var request = $.ajax({

        url: 'https://api.github.com/authorizations',
        type: 'POST',

        data: '{ "scopes": [ "repo" ], "note": "Created by list-issues.js"  }',

        username: user,
        password: password,

        success: function(data){
            helpers.logDebug('getOauthToken: Yea, it worked...' + JSON.stringify(data) );
            oauthToken = data;
        },

        error: function(data){
            helpers.logErr('getOauthToken: Shit hit the fan...' + JSON.stringify(data));

        }
    });

    return request;
        
}

switch (argv.cmd) {

    case "test":
        helpers.logDebug('main: test command...');
        break;

    case "test2":
        helpers.logDebug('main: test command...');
        break;

    default:
        helpers.logErr('No such command: ' + argv.cmd);

}

}());