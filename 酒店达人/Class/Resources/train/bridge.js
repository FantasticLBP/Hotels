/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(1);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(2),__webpack_require__(3),__webpack_require__(5)], __WEBPACK_AMD_DEFINE_RESULT__ = function(bridge,delegate) {
		// var fw = {};
		var ErrCode = {
			0:"success",
			1:"input error",
			2:"common error",
			3:"cancel",
		};
		//异步加载/同步加载
		bridge.ErrCode = ErrCode;
		bridge.delegate = delegate;
		// bridge.delegateWx = delegateWx;

		window.ElongBridge = bridge;

		return bridge;
	}.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));

/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_RESULT__ = function(){
		var fw = {};
		//1. 确定runtime和版本号
		// 目前支持 elongAPP内嵌
		window.$IOSVERSION = 7;
		var ua = navigator.userAgent.toLowerCase();

		var getScript = function(url,cb){
	        var script = document.createElement('script');
	        script.setAttribute('src', url);
	        document.head.appendChild(script);
	        script.onload = function(){
	            if(cb){cb(script);}
	        };
	    };
	    var fire = function(type){
	    	if (typeof CustomEvent === 'function') {
		        e = new CustomEvent(type, opt);
		    } else {
		        e = document.createEvent('Events');
		        e.initEvent(type, opt.bubbles, opt.cancelable, opt.detail);
		    }
		    document.dispatchEvent(e);
		    
	    }

		if (ua.match(/ ew(\w+)\/([\d.-_]*)/i)) {//添加runtime的判断
			var version = ua.match(/ ew\w+\/([\d.-_]*)/i)[1];
			//预处理version
			if (version.match(/[1-9]\.[^_]*/)){
				version = version.match(/[1-9]\.[^_]*/)[0];
			}
			fw.RUNTIME_VERSION = version;
		}else{
			fw.RUNTIME_VERSION = '';
		}

		if (ua.match(/ micromessenger/) ) {//微信环境
			getScript("/lib/jweixin-1.1.0.js",function(){
				fire("wxjsok");
			})
		}

		

		//2. 确定PLATFORM
		if (ua.match(/android/i)){
			fw.PLATFORM = 1;
		}else if (ua.match(/(iphone)|(ipad)|(ipod)/i)){
			fw.PLATFORM = 2;
		}else{
			fw.PLATFORM = 0;
		}

		if(fw.RUNTIME_VERSION && fw.PLATFORM == 2){
			var pages = document.getElementsByClassName('pages')[0];

			//要记得判空啊啊啊啊！！！
			if(!!pages) {
				if (ua.match(/OS 6[_\d]+ like Mac OS X/i)) {
		           	$IOSVERSION=6;
		           	pages.className += ' pages-app6';
		        }else{
		        	pages.className += ' pages-app';
		        }
			}
		}

		fw.ready = function(cb){
			if (/complete|loaded|interactive/.test(document.readyState)) {
				cb();
				return;
			} else {
				document.addEventListener('DOMContentLoaded', cb, false);
				return;
			}
		};
		return fw;

		//3. APP内嵌H5
		
	}.call(exports, __webpack_require__, exports, module), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));

/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(2),__webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = function(bridge,util){

		var timeout=3000;//最迟500ms后触发
		var timeoutid;
		
		//创建唯一的id，用于管理app 内嵌回调
		var uniq = util.uniq;
		//传入干净的内嵌app的参数（去除onsuccess和onfail）
		var cleanoptions = util.cleanoptions;


		var callbackStack=[];

		var hasElongApp = -1;
		
		var supporterror = {error:2,msg:"runtime does not support this function"+name};

		if (typeof ElongApp === 'undefined') {

			var readyFunctions = function(){
				if (callbackStack.length) {
					
					for (var i=0,len=callbackStack.length;i<len;i++){
						if (typeof ElongApp !=='undefined' && typeof  ElongApp[callbackStack[i][0]] ==='function') {
							
							if (callbackStack[i][2]){
								ElongApp[callbackStack[i][0]](callbackStack[i][1],callbackStack[i][2]);
							}else{
								ElongApp[callbackStack[i][0]](callbackStack[i][1]);
							}
							
						}else{
							window.eval(callbackStack[i][1])(supporterror);
						}
						
					}
					callbackStack.length=0;
				}
			};

			if ( ( location.search.match(/[?|&]inElongApp=1/) || bridge.RUNTIME_VERSION >= '8.4.0') && bridge.PLATFORM === 2) {
			//ios平台会需要等待触发ready事件，安卓平台不需要，如果安卓将来需要，把polatform限制打开
				hasElongApp = 0;//waiting state
				
				timeoutid=setTimeout(function(){
					console.log("timeout! waiting for the ElongAppReady for " + timeout +"ms");
					hasElongApp = -1;//none
					ElongApp = {};
					
					if (typeof Event === 'function') {
	                    var e = new Event('ElongAppReady', {detail:"0"});
	                    document.dispatchEvent(e);
	                }

					readyFunctions();
				},timeout);
				document.addEventListener("ElongAppReady",function(ev){
					clearTimeout(timeoutid);
					if ( !bridge.RUNTIME_VERSION && ev.detail && ev.detail.length>1 ) {//防止‘0’的情况
						bridge.RUNTIME_VERSION = ev.detail;
					}
					hasElongApp = 1;//ready
					readyFunctions();
				});
			}
		}else{
			hasElongApp = 1;
		}
		
		


		//用于存放来自native js的callback
		var jscallbacks = {};

		
		window.jscallbacks = jscallbacks;

		var callbackoptions = {};



		return function(name,options){

			if (!options || !options.onsuccess) {
				console.warn("no options.onsuccess found..");
				options = options || {};
				options.onsuccess = function(){};
				// return;
			}

			var key = uniq();

			var cbkey = "cb"+key;

			//保存options
			callbackoptions[cbkey] = options;

			//不需要兼容了，统一为function。options.onsuccess是方法(function)还是方法名(string)
			//处理通用的callback回调 callback
			jscallbacks[cbkey] = function(data){
				var data2;
				if (typeof data === 'string')
					data2 = JSON.parse(data);
				else{
					data2 = data;
				}
				var myoptions = callbackoptions[cbkey];
				
				if(!!data2.err){
					myoptions.onprogress(data2);
				}
				else if (!data2.error&&!data2.err){//data2.err.code是兼容update方法){
					myoptions.onsuccess(data2);
				}else{
					console.error(data2);
					if (myoptions.onfail){
						myoptions.onfail(data2);
					}
					
				}
			}

			if (hasElongApp === 0) {
				callbackStack.push([name,"jscallbacks['"+cbkey+"']",cleanoptions(options)]);
			}else{
				if (typeof ElongApp !=='undefined' && typeof ElongApp[name] ==='function') {
					var cbopt = cleanoptions(options);

					if (cbopt){
						ElongApp[name]("jscallbacks['"+cbkey+"']",cleanoptions(options));
					}else{
						ElongApp[name]("jscallbacks['"+cbkey+"']");
					}
					
				}else{
					console.error(supporterror);
					options && options.onfail && options.onfail(supporterror);
				}
				
			}
			
			
		};
	}.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));

/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_RESULT__ = function(){
		var util={};
		var uid = 22;
		var hasOwnProperty = Object.prototype.hasOwnProperty;

	 
		util.clone = function(source) {
			if (!source || typeof source !== 'object') {
				return source;
			}

			//source为数组
			if(typeof source.splice === 'function' && typeof source.push === 'function') {
				var newArr = [];

				for(var i = 0; i < source.length; i ++) {
					newArr[i] = util.clone(source[i]); 
				}

				return newArr;
			} else {
				var newObj = {}; 

				for(var i in source){  
					newObj[i] = util.clone(source[i]); 
				}  
				return newObj;
			}  
		};
		
		util.isEmpty = function(obj) {

			// null and undefined are "empty"
			if (obj === null) return true;

			// Assume if it has a length property with a non-zero value
			// that that property is correct.
			if (obj.length > 0)    return false;
			if (obj.length === 0)  return true;

			// Otherwise, does it have any properties of its own?
			// Note that this doesn't handle
			// toString and valueOf enumeration bugs in IE < 9
			for (var key in obj) {
				if (hasOwnProperty.call(obj, key)) return false;
			}

			return true;
		}
		util.cleanoptions = function(options){
			var optcopy;
			if (typeof options === 'object') {
				optcopy = util.clone(options);
				delete optcopy.onsuccess;
				delete optcopy.onfail;
				//update api
			delete optcopy.onprogress;
			}
			return util.isEmpty(optcopy)?"":JSON.stringify(optcopy);
		};

		util.uniq = function(){
			return uid++;
		};
		util.getScript = function(url,cb){
	        var script = document.createElement('script');
	        script.setAttribute('src', url);
	        document.head.appendChild(script);
	        script.onload = function(){
	            if(cb){cb(script);}
	        };
	    };
	    util.fire = function(type){
	    	var opt={};
	    	if (typeof CustomEvent === 'function') {
		        e = new CustomEvent(type, opt);
		    } else {
		        e = document.createEvent('Events');
		        e.initEvent(type, opt.bubbles, opt.cancelable, opt.detail);
		    }
		    document.dispatchEvent(e);
	    }
		return util;
	}.call(exports, __webpack_require__, exports, module), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));

/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(2),__webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = function(bridge,util){
		//account
		// App 需要在进入 H5 时传入以下保留字段：ref={渠道号}&clienttype={客户端类型}&version={版本号}&sessiontoken={SessionToken}
		
		//找一个在刷新页面的是偶也可以保留的参数和回调
		var geturlParam = function(key){
			var reg = new RegExp(key+"="+"([^&]*)");
			if (location.href.match(reg)) {
				return location.href.match(reg)[1];
			}
			return '';
		}
		
		bridge.appCallBackList = {};
		
		bridge.accountLogin = function(options){
			//in container
			// if ( bridge.RUNTIME_VERSION ) {//for test
				bridge.delegate("accountLogin",options);
				//url 跳转拦截退化
				// accountUrlHold("login",options);
				
			// }
			
		};

		bridge.accountGet = function(options){
			//in container
			// if ( bridge.RUNTIME_VERSION ) {
				bridge.delegate("accountGet",options);
				// url 跳转拦截退化
				// accountUrlHold("getsessiontoken",options);
				
			// }
		};

		bridge.locationGet = function(options){
			// if (bridge.isWx) {
			// 	bridge.delegateWx("getLocation",options);
			// }else{
				bridge.delegate("locationGet",options);
			// }
		};

		bridge.shareWx = function(options){
			if (options.img_url){// 兼容安卓，安卓使用了大小混合写的参数，ios使用了下划线的参数
				options.imgUrl = options.img_url;
			}else{
				options.img_url = options.imgUrl;
			}

			if (bridge.RUNTIME_VERSION != '8.4.0' && bridge.PLATFORM === 2) {//8.5.0 之后ios 系统去掉了shareWx接口
				options.type = '3';
				options.imgWidth = options.imgWidth || "640";
				options.imgHeight = options.imgHeight || "640";
				bridge.delegate("share",options);
			} else{
				bridge.delegate("shareWx",options);
			}
			
		};

		bridge.share = function(options){

			bridge.delegate("share",options);

		};


		bridge.showBtn = function(options){
			// if ( bridge.RUNTIME_VERSION ) {
				//in container
				bridge.delegate("showBtn",options);
			// }
		};

		bridge.appPage = function(options){
			bridge.delegate("appPage",options);
		};

		bridge.setNavbar = function(options){
			bridge.delegate("setNavbar",options);
		}

		bridge.showCollectBtn = function(options){
	        bridge.delegate("showCollectBtn",options);
	    };

		bridge.takeMeTo = function(options){
			bridge.delegate("takeMeTo", options);
		}

		bridge.closeH5Page = function(options){
			bridge.delegate("closeH5Page", options);
		}

		bridge.pay = function(options){
			bridge.delegate("pay",options);
		}

		bridge.getTelephone = function(options){
			bridge.delegate("getTelephone",options);
		}

		bridge.update = function(options){
			bridge.delegate("update",options);
		}

		bridge.setAppCallback = function(name, callback){
			bridge.appCallBackList[name] = callback;
		}

		bridge.appCallback = function(name, params){
			if(typeof bridge.appCallBackList[name] == 'function') {
				bridge.appCallBackList[name](params);
			} else {
				console.error('Could not find callback named ' + name);
			}
		}
		
		bridge.sendMessage = function(options){
			bridge.delegate("sendMessage", options);
		}
		bridge.getPublicAttris = function(options){
			bridge.delegate("getPublicAttris", options);
		}

		bridge.googleMapReady = function(options){
			bridge.delegate("googleMapReady", options);
		}

		return bridge;
	}.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));

/***/ }
/******/ ]);
