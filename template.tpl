___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Phone/Mobile Normalizer \u0026 SHA256 Hasher",
  "categories": ["UTILITY"],
  "description": "Use this variable to normalize \u0026 hash any phone/mobile number with SHA256 after formatting the value to the desired format. i.e. removing leading zero, plus sign, dashes, brackets, white spaces.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "input",
    "displayName": "Value to hash",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "toLowerCase",
    "checkboxText": "Convert to Lower Case",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "removeWhiteSpaces",
    "checkboxText": "Remove White Spaces",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "removePlus",
    "checkboxText": "Remove \"+\" From The beginning of the input",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "removeLeadingZero",
    "checkboxText": "Remove Leading Zero \u002700\u0027",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "removeBrackets",
    "checkboxText": "Remove Brackets \u0027(\u0027 OR \u0027)\u0027",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "removeDashes",
    "checkboxText": "Remove Dashes \"-\"",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const sha256Sync = require('sha256Sync');
var toHash = data.input;

const replaceAll = function(str, oldstr, newstr) {
  var rs = str;
  if (oldstr === newstr) return rs;
  while (rs.indexOf(oldstr) >= 0)
    rs = rs.replace(oldstr, newstr);
  return rs;
}; 

function isAlreadyHashed(input){
  return input && (input.match('^[A-Fa-f0-9]{64}$') != null);
}


function hashFunction(input){
  if(input == null || input == 'undefined' || isAlreadyHashed(toHash)){
    return input;
  }

  if (data.removePlus){toHash = replaceAll(toHash, '+', '');}
  if (data.toLowerCase) {toHash = toHash.toLowerCase();}
  if (data.removeWhiteSpaces) {toHash = replaceAll(toHash, ' ', '');}
  if (data.removeLeadingZero) {toHash = toHash.replace('00', '');}
  if (data.removeBrackets) {toHash = replaceAll(replaceAll(toHash, '(', ''), ')', '');}
  if (data.removeDashes) {toHash = replaceAll(toHash, '-', '');}
  
  return sha256Sync(toHash.trim().toLowerCase(), {outputEncoding: 'hex'});
}

return hashFunction(toHash);


___TESTS___

scenarios: []


___NOTES___

Created on 8/15/2022, 5:25:17 PM


