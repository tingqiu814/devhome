window.YYPAY={}
/* 
 * Copyright 2010 Nicholas C. Zakas. All rights reserved. 
 * BSD Licensed. 
 * modified by wushufeng 2014-07-01 
 */
YYPAY.XDStorage = function(origin, path){
    this.origin = origin;
    this.path = path;
    this._iframe = null;
    this._iframeReady = false;
    this._queue = [];
    this._requests = {};
    this._id = 0;
}

YYPAY.XDStorage.prototype = {

    op:{
        WRITE: 'W',
        READ: 'R',
        DEL: 'D',
        CLEAR: 'X'
    },
    //restore constructor  
    constructor: YYPAY.XDStorage,

    //public interface methods  

    init: function(){

        var that = this;

        if (!this._iframe){
            if (window.postMessage && window.JSON && window.localStorage){
                this._iframe = document.createElement("iframe");
                this._iframe.style.cssText = "position:absolute;width:1px;height:1px;left:-9999px;";
                document.body.appendChild(this._iframe);

                if (window.addEventListener){
                    this._iframe.addEventListener("load", function(){ that._iframeLoaded(); }, false);
                    window.addEventListener("message", function(event){ that._handleMessage(event); }, false);
                } else if (this._iframe.attachEvent){
                    this._iframe.attachEvent("onload", function(){ that._iframeLoaded(); }, false);
                    window.attachEvent("onmessage", function(event){ that._handleMessage(event); });
                }
            } else {
                throw new Error("Unsupported browser.");
            }
        }

        this._iframe.src = this.origin + this.path;

    },

    getValue: function(key, callback){
        this._toSend({
            key: key
        },callback);
    },

    setValue: function(key,value,callback){

        this._toSend({
            key: key,
            op:  this.op.WRITE,
            value: value
        },callback);
    },
    delValue: function(key,callback){
        this._toSend({
            key: key,
            op: this.op.DEL,
            value: value
        },callback);
    },
    clearValue: function(callback){
        this._toSend({
            op: this.op.CLEAR
        },callback);
    },
    //private methods  

    _toSend: function(params,callback){
        var data = {
            request: {
                key: params.key,
                id: ++this._id,
                op: params.op,
                value: params.value
            },
            callback: callback
        };
        if (this._iframeReady){
            this._sendRequest(data);
        } else {
            this._queue.push(data);
        }

        if (!this._iframe){
            this.init();
        }
    },

    _sendRequest: function(data){
        this._requests[data.request.id] = data;
        this._iframe.contentWindow.postMessage(JSON.stringify(data.request), this.origin);
    },

    _iframeLoaded: function(){
        this._iframeReady = true;

        if (this._queue.length){
            for (var i=0, len=this._queue.length; i < len; i++){
                this._sendRequest(this._queue[i]);
            }
            this._queue = [];
        }
    },

    _handleMessage: function(event){
        if (event.origin == this.origin){
            var data = JSON.parse(event.data);
            this._requests[data.id].callback && this._requests[data.id].callback(data.key, data.value);
            delete this._requests[data.id];
        }
    }

};
