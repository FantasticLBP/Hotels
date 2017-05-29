/*TMODJS:{"version":"1.0.0"}*/
!function() {
    function template(filename, content) {
        return (/string|function/.test(typeof content) ? compile : renderFile)(filename, content);
    }
    function toString(value, type) {
        return "string" != typeof value && (type = typeof value, "number" === type ? value += "" : value = "function" === type ? toString(value.call(value)) : ""), 
        value;
    }
    function escapeFn(s) {
        return escapeMap[s];
    }
    function escapeHTML(content) {
        return toString(content).replace(/&(?![\w#]+;)|[<>"']/g, escapeFn);
    }
    function each(data, callback) {
        if (isArray(data)) for (var i = 0, len = data.length; len > i; i++) callback.call(data, data[i], i, data); else for (i in data) callback.call(data, data[i], i);
    }
    function resolve(from, to) {
        var DOUBLE_DOT_RE = /(\/)[^\/]+\1\.\.\1/, dirname = ("./" + from).replace(/[^\/]+$/, ""), filename = dirname + to;
        for (filename = filename.replace(/\/\.\//g, "/"); filename.match(DOUBLE_DOT_RE); ) filename = filename.replace(DOUBLE_DOT_RE, "/");
        return filename;
    }
    function renderFile(filename, data) {
        var fn = template.get(filename) || showDebugInfo({
            filename: filename,
            name: "Render Error",
            message: "Template not found"
        });
        return data ? fn(data) : fn;
    }
    function compile(filename, fn) {
        if ("string" == typeof fn) {
            var string = fn;
            fn = function() {
                return new String(string);
            };
        }
        var render = cache[filename] = function(data) {
            try {
                return new fn(data, filename) + "";
            } catch (e) {
                return showDebugInfo(e)();
            }
        };
        return render.prototype = fn.prototype = utils, render.toString = function() {
            return fn + "";
        }, render;
    }
    function showDebugInfo(e) {
        var type = "{Template Error}", message = e.stack || "";
        if (message) message = message.split("\n").slice(0, 2).join("\n"); else for (var name in e) message += "<" + name + ">\n" + e[name] + "\n\n";
        return function() {
            return "object" == typeof console && console.error(type + "\n\n" + message), type;
        };
    }
    var cache = template.cache = {}, String = this.String, escapeMap = {
        "<": "&#60;",
        ">": "&#62;",
        '"': "&#34;",
        "'": "&#39;",
        "&": "&#38;"
    }, isArray = Array.isArray || function(obj) {
        return "[object Array]" === {}.toString.call(obj);
    }, utils = template.utils = {
        $helpers: {},
        $include: function(filename, data, from) {
            return filename = resolve(from, filename), renderFile(filename, data);
        },
        $string: toString,
        $escape: escapeHTML,
        $each: each
    }, helpers = template.helpers = utils.$helpers;
    template.get = function(filename) {
        return cache[filename.replace(/^\.\//, "")];
    }, template.helper = function(name, helper) {
        helpers[name] = helper;
    }, "function" == typeof define ? define(function() {
        return template;
    }) : "undefined" != typeof exports ? module.exports = template : this.template = template, 
    /*v:7*/
    template("activity", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, isShowHeader = $data.isShowHeader, bannerNote = $data.bannerNote, $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += "'/>  ", isShowHeader && ($out += ' <header id="activity-page-header" class="bar bar-nav bar-train"> <a class="icon icon-left-nav pull-left" data-rel="back" href=""></a> <span class="header-order-button pull-right"></span> <h1 class="title">', 
        $out += $escape(bannerNote), $out += "</h1> </header> "), $out += ' <div id="activity-page-content" class="page-content"> <iframe class="activity-page" style="width: 100%;height: 100%;border: none; overflow: auto;"></iframe> </div>  </div> ', 
        new String($out);
    }), /*v:1*/
    template("bind12306", function($data) {
        "use strict";
        var $utils = this, isShowHeader = ($utils.$helpers, $data.isShowHeader), $escape = $utils.$escape, isBind12306Flag = $data.isBind12306Flag, image = $data.image, train12306UserName = $data.train12306UserName, $out = "";
        return $out += '<div class="page"> ', isShowHeader && ($out += ' <header class="bar bar-nav" id="bind12306Page-header"> <a class="icon icon-left-nav pull-left" id="a_f_download" data-rel="back" href="/train/"></a>  <h1 class="title">12306账号绑定</h1> </header> '), 
        $out += ' <div class="page-content" id="bind12306Page-content">  <input type="hidden" id="isBind12306Hidden" value="', 
        $out += $escape(isBind12306Flag), $out += '"/> <div class="banner"> <img src="http://promotion.elong.com/wireless/H5/html/bus/images/bind12306-banner.jpg"/> </div> <div class="unbind"> <ul class="bind12306-wrap"> <li class="verify-wrap"> <input class="account" type="text" placeholder="请输入12306账户名"> </li> <li class="verify-wrap"> <input class="password" type="password" placeholder="请输入12306密码"/> </li> <li class="verify-wrap verify-box clearfix"> <span>验证码</span> <em class="reload-img"></em> </li> <li class="verify-wrap verify-pic"> <div class="img-wrap"> <img class="verify-img" src="', 
        $out += $escape(image), $out += '"> <div class="imgTags"> </div> </div> </li> </ul> <button class="btn btn-block btn_bind12306">立刻绑定</button> <div class="nav12306 clearfix"> <a class="nav12306-forget" href="https://kyfw.12306.cn/otn/forgetPassword/initforgetMyPassword"> 忘记密码？ </a> <a class="nav12306-reg"> 注册12306账户 </a> </div> </div> <div class="binded"> <div class="account"> <label class="account-label">已绑定账号：</label> <span class="account-text">', 
        $out += $escape(train12306UserName), $out += '</span> </div> <div class="nav12306 clearfix"> <a class="nav12306-change" href="javascript:;">更换绑定账号&gt;&gt;</a> <a class="nav12306-remove" href="javascript:;" >解除绑定</a> </div> </div> </div> </div>', 
        new String($out);
    }), /*v:23*/
    template("detail", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, isSendTicket = $data.isSendTicket, loginFlag = $data.loginFlag, loginUrl = $data.loginUrl, adultPreSale = $data.adultPreSale, studentPreSale = $data.studentPreSale, selfPaySwitch = $data.selfPaySwitch, train12306LoginUrl = $data.train12306LoginUrl, isShowHeader = $data.isShowHeader, orderFillInfo = $data.orderFillInfo, startEndTicketInfo = $data.startEndTicketInfo, orderDetailTipTitle = $data.orderDetailTipTitle, orderDetailTipContent = $data.orderDetailTipContent, orderDetailTipUrl = $data.orderDetailTipUrl, $each = $utils.$each, detailGradeTitle = ($data.seat, 
        $data.$index, $data.detailGradeTitle), hasDataFlag = $data.hasDataFlag, userName = $data.userName, bannerNote = $data.bannerNote, bannerLink = $data.bannerLink, bannerLogin = $data.bannerLogin, bannerUrl = $data.bannerUrl, $out = "";
        return $out += '<div class="page "> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\'/> <input type="hidden" id="isSendTicket" value="', 
        $out += $escape(isSendTicket), $out += '"/> ', $out += loginFlag ? ' <input type="hidden" id="loginFlag" value="true"/> ' : ' <input type="hidden" id="loginFlag" value="false"/> ', 
        $out += ' <input type="hidden" id="loginUrl" value="', $out += $escape(loginUrl), 
        $out += '"/> <input type="hidden" id="adultPreSale" value="', $out += $escape(adultPreSale), 
        $out += '"/> <input type="hidden" id="studentPreSale" value="', $out += $escape(studentPreSale), 
        $out += '"/> ', $out += selfPaySwitch ? ' <input type="hidden" id="train_12306_switch_hidden" value="true"/> ' : ' <input type="hidden" id="train_12306_switch_hidden" value="false"/> ', 
        $out += ' <input type="hidden" id="train12306LoginUrlHidden" value="', $out += $escape(train12306LoginUrl), 
        $out += '"/> ', isShowHeader && ($out += ' <header class="bar bar-nav " id="detailPage-header"> <a class="icon icon-left-nav pull-left" data-rel=\'back\' href="/train/"></a> <h1 class="title">选择座席</h1>  </header> '), 
        $out += ' <nav class="bar nav-train-list"> <a class="pre-day-btn left-triangle-icon disabled" href="javascript:;">前一天</a> ', 
        orderFillInfo && ($out += ' <a class="date-btn" href="javascript:;" data-date="', 
        $out += $escape(orderFillInfo.startdate), $out += '"> <span class="icon icon-time"></span> <span class="date-btn-text"></span> </a> '), 
        $out += ' <a class="next-day-btn right-triangle-icon disabled" href="javascript:;">后一天</a> </nav> <div class="page-content" id="detailPage-content"> ', 
        startEndTicketInfo ? ($out += ' <article> <section class="info"> <div class="clearfix"> <div class="start"> <div class="station j-startstation">', 
        $out += $escape(startEndTicketInfo.from.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.from.time), $out += "</div> ", orderFillInfo && ($out += ' <div class="date">', 
        $out += $escape(orderFillInfo.startDateStr), $out += "</div> "), $out += ' </div> <div class="train"> <div class="during">', 
        $out += $escape(startEndTicketInfo.duration), $out += '</div> <div class="schedule"> <div class="schedule-left"></div> <div class="schedule-content">列车时刻表</div> <div class="schedule-right"></div> </div> <div class="coach">', 
        $out += $escape(startEndTicketInfo.trainNumber), $out += '</div> </div> <div class="end"> <div class="station j-endstation">', 
        $out += $escape(startEndTicketInfo.to.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.to.time), $out += "</div> ", orderFillInfo && ($out += ' <div class="date">', 
        $out += $escape(orderFillInfo.endDateStr), $out += "</div> "), $out += " </div> </div> </section> ", 
        orderDetailTipTitle && "" != orderDetailTipTitle && ($out += ' <section class="notice"> <div class="remind" data="', 
        $out += $escape(orderDetailTipContent), $out += '"> ', orderDetailTipUrl ? ($out += ' <a href="', 
        $out += $escape(orderDetailTipUrl), $out += '">', $out += $escape(orderDetailTipTitle), 
        $out += "</a> ") : ($out += " ", $out += $escape(orderDetailTipContent), $out += " "), 
        $out += " </div> </section> "), $out += ' <section class="seatingrade"> ', startEndTicketInfo.seatList ? ($out += " ", 
        $each(startEndTicketInfo.seatList, function(seat) {
            $out += ' <div class="grade-item" data-seatTypeCode="', $out += $escape(seat.seatTypeCode), 
            $out += '"> <div class="grade-base clearfix"> <div class="setting">', $out += $escape(seat.seatTypeName), 
            $out += '</div> <div class="price">￥', $out += $escape(seat.price), $out += "</div> ", 
            0 == seat.yp ? $out += ' <div class="operate"> <a class="forbidden">预订</a> </div> <span class="remainder">0张</span> ' : (seat.yp = -1) ? $out += ' <div class="operate"> <a class="allow j-allow" data-state="contract">预订</a> </div> <div class="remainder">有票</div> ' : ($out += ' <div class="operate"> <a class="allow j-allow" data-state="contract">预订</a> </div> <div class="remainder">', 
            $out += $escape(seat.yp), $out += "张</div> "), $out += ' </div> <div class="grade-detail clearfix hide"> <div class="grade-detail-item clearfix"> <div class="grad-detail-item-wrap clearfix"> <div class="grade-12306-icon"> </div> <div class="grade-detail-title"> <div class="grade-detail-title-first">使用12306账号预订</div> <div class="grade-detail-title-second">第一时间秒抢火车票</div> </div> <div class="grade-detail-operate"> <a class="allow j-12306-allow">预订</a> </div> </div> </div> <div class="grade-detail-item clearfix"> <div class="grad-detail-item-wrap clearfix"> <div class="grade-elong-icon"></div> <div class="grade-detail-title"> ', 
            detailGradeTitle ? ($out += ' <div class="grade-detail-title-first"> 使用', $out += $escape(detailGradeTitle), 
            $out += "预订 </div> ") : $out += ' <div class="grade-detail-title-first">使用艺龙账号预订</div> ', 
            $out += ' <div class="grade-detail-title-second">支持24小时订票</div> </div> <div class="grade-detail-operate"> <a class="allow j-elong-allow">预订</a> </div> </div> </div> <div class="grade-detail-item clearfix"> <div class="grad-detail-item-wrap clearfix"> <div class="grade-ticket-icon"></div> <div class="grade-detail-title"> <div class="grade-detail-title-first">在线选座+送票上门</div> <div class="grade-detail-title-second">指定座席,免身份核验</div> </div> <div class="grade-detail-operate"> <a class="allow j-ticket-allow">预订</a> </div> </div> </div> </div> </div> ';
        }), $out += " ") : 0 == hasDataFlag && ($out += ' <div class="page-error-info"> 没有座席数据，可能是网络异常，请稍后重试! </div> '), 
        $out += " </section> </article> ") : 0 == hasDataFlag && ($out += ' <div class="page-error-info"> 没有座席数据，可能是网络异常，请稍后重试! </div> '), 
        $out += " ", orderFillInfo && ($out += ' <input type="hidden" id="start" value="', 
        $out += $escape(orderFillInfo.startstation), $out += '"/> <input type="hidden" id="end" value="', 
        $out += $escape(orderFillInfo.endstation), $out += '"/> <input type="hidden" id="trainNumer" value="', 
        $out += $escape(orderFillInfo.trainNum), $out += '"/> '), $out += ' </div> <div class="time-list page-plugin plugin-inited"> <div class="bar bar-nav"> <div class="time-list-close">关闭</div> </div> <div class="page-content"> <div class="list-title">列车时刻表</div> </div> </div> ', 
        userName ? ($out += '  <div class="banner-12306 clearfix 12306-footer-banner" data-note="', 
        $out += $escape(bannerNote), $out += '" data-link="', $out += $escape(bannerLink), 
        $out += '" data-bannerLogin="', $out += $escape(bannerLogin), $out += '"> <div class="banner-12306-content"> <div class="banner-12306-icon"></div> <div class="banner-12306-title"> <div class="banner-12306-title-first">12306账号管理</div> <div class="banner-12306-title-second">', 
        $out += $escape(userName), $out += "( 已绑定 )</div> </div> </div> </div> ") : ($out += " ", 
        bannerUrl && ($out += '  <div class="banner-12306-img 12306-footer-banner" data-note="', 
        $out += $escape(bannerNote), $out += '" data-link="', $out += $escape(bannerLink), 
        $out += '" data-bannerLogin="', $out += $escape(bannerLogin), $out += '"> <img class="banner-12306-img-img" src="', 
        $out += $escape(bannerUrl), $out += '" alt=""> </div> '), $out += " "), $out += " </div> ", 
        new String($out);
    }), /*v:5*/
    template("entry", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, adultPreSale = $data.adultPreSale, studentPreSale = $data.studentPreSale, dataSign = $data.dataSign, isShowHeader = $data.isShowHeader, bannerUrl = $data.bannerUrl, bannerNote = $data.bannerNote, bannerLink = $data.bannerLink, bannerList = $data.bannerList, $each = $utils.$each, tipTitle = ($data.imgobj, 
        $data.$index, $data.tipTitle), tipContent = $data.tipContent, tipUrl = $data.tipUrl, myelongLoginUrl = $data.myelongLoginUrl, myelongIndexUrl = $data.myelongIndexUrl, loginFlag = $data.loginFlag, $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\'/> <input type="hidden" id="adultPreSale" value="', 
        $out += $escape(adultPreSale), $out += '"/> <input type="hidden" id="studentPreSale" value="', 
        $out += $escape(studentPreSale), $out += '"/> <input type="hidden" id="hiddenDataSign" value="', 
        $out += $escape(dataSign), $out += '"/>  ', isShowHeader && ($out += ' <header class="bar bar-nav bar-train" id="indexPage-header"> <a class="icon icon-left-nav pull-left" id="a_f_download" data-rel="back"></a>  <h1 class="title">火车票</h1> </header> '), 
        $out += ' <div class="page-content" id="indexPage-content"> <article class="temp-info"> <!--', 
        bannerUrl && ($out += ' <div class="promotion" data-note="', $out += $escape(bannerNote), 
        $out += '" data-link="', $out += $escape(bannerLink), $out += '"> <img src="', $out += $escape(bannerUrl), 
        $out += '" alt=""/> &lt;!&ndash;<img src="http://pavo.elongstatic.com/i/ori/0004SLea.jpg" alt=""/>&ndash;&gt; </div> '), 
        $out += "-->  ", bannerList && ($out += ' <div class="swiper-container swiper-container-horizontal entry-swiper"> <div class="swiper-wrapper"> ', 
        $each(bannerList, function(imgobj) {
            $out += ' <div class="swiper-slide"> <a data-href="', $out += $escape(imgobj.link), 
            $out += '" data-login="', $out += $escape(imgobj.login), $out += '" data-note="', 
            $out += $escape(imgobj.note), $out += '"> <img src="', $out += $escape(imgobj.url), 
            $out += '" alt=""> </a> </div> ';
        }), $out += ' </div> <div class="swiper-pagination swiper-pagination-clickable"></div> </div> '), 
        $out += " ", tipTitle ? ($out += ' <div class="remind" data="', $out += $escape(tipContent), 
        $out += '"> ', tipUrl ? ($out += ' <a href="', $out += $escape(tipUrl), $out += '">', 
        $out += $escape(tipTitle), $out += "</a> ") : ($out += " ", $out += $escape(tipTitle), 
        $out += " "), $out += " </div> ") : $out += " ", $out += '  </article> <article class="train-search"> <section class="operate"> <div class="station clearfix"> <div class="choose-station choose-station-start"> <div class="station-title">出发城市</div> <div class="choose-btn start"><span></span></div> </div> <div class="switch"> <div class="switch-btn"></div> </div> <div class="choose-station choose-station-end"> <div class="station-title">到达城市</div> <div class="choose-btn end"><span></span></div> </div> </div> <div class="date"> <div class="date-title">出发日期</div> <div class="date-region"> <span></span> <em>今天</em> <input type="hidden" id="time" value=""/> </div> </div> <div class="filter clearfix"> <label class="transtypeCheck"> 只看动车/高铁 </label> <div class="check-box label-checkbox"> <span class="checkbox"></span> </div> </div> </section> </article> <article class="goSearch"> <section class="search"> <div class="btn btn-primary btn-block"><span>查询</span></div> </section> <section class="horizontal-line"></section> <section class="history"> </section> <form class="search-form"> <input type="hidden" id="startstation" value=""> <input type="hidden" id="endstation" value=""> <input type="hidden" id="startdate" value=""> <input type="hidden" id="traintype" value="0"> </form> </article> </div> <nav class="bar bar-tab" id="indexPage-footer"> ', 
        myelongLoginUrl ? ($out += ' <input type="hidden" value="', $out += $escape(myelongLoginUrl), 
        $out += '" id="myelongLoginUrl"> ') : $out += " ", $out += ' <input type="hidden" value="', 
        $out += $escape(myelongIndexUrl), $out += '" id="myelongIndexUrl"> <a class="tab-item order-tip"> <span class="item-icon"></span> <span class="item-text">预订须知</span> </a> <!--', 
        $out += loginFlag ? ' <a class="tab-item my-order my-order-login"> <span class="item-icon"></span> <span class="item-text">查看订单</span> </a> ' : ' <a class="tab-item my-order my-order-nologin"> <span class="item-icon"></span> <span class="item-text">查看订单</span> </a> ', 
        $out += '--> <a class="tab-item my-order my-order-login"> <span class="item-icon"></span> <span class="item-text">查看订单</span> </a> </nav>  </div> ', 
        new String($out);
    }), /*v:2*/
    template("list", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, adultPreSale = $data.adultPreSale, studentPreSale = $data.studentPreSale, isShowHeader = $data.isShowHeader, startEndTicketInfoList = $data.startEndTicketInfoList, $each = $utils.$each, startEndStationPojo = ($data.startEndTicketInfo, 
        $data.$index, $data.startEndStationPojo), hasDataFlag = $data.hasDataFlag, $out = "";
        return $out += '<div class="page page-list"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\' /> <input type="hidden" id="adultPreSale" value="', 
        $out += $escape(adultPreSale), $out += '" /> <input type="hidden" id="studentPreSale" value="', 
        $out += $escape(studentPreSale), $out += '" />  <input type="hidden" id="deviceHidden"/> ', 
        isShowHeader && ($out += ' <header class="bar bar-nav " id="listPage-header"> <a class="icon icon-left-nav pull-left" data-rel=\'back\' href="/train/"></a> <h1 class="title">火车列表</h1>  </header> '), 
        $out += ' <nav class="bar nav-train-list"> <a class="pre-day-btn left-triangle-icon" href="javascript:;">前一天</a> <a class="date-btn" href="javascript:;" data-date="2015-06-03"> <span class="icon icon-time"></span> <span class="date-btn-text"></span> </a> <a class="next-day-btn right-triangle-icon" href="javascript:;">后一天</a> </nav> <nav class="bar bar-tab" id="listPage-footer"> <a class="tab-item start-sort"><span class="tabItem-icon"></span><span class="tabItem-text"></span></a> <a class="tab-item during-sort"> <span class="tabItem-icon"></span><span class="tabItem-text"></span></a> <a class="tab-item price-sort"> <span class="tabItem-icon"></span><span class="tabItem-text"></span></a> <a class="tab-item coach-filter"><span class="tabItem-icon"></span><span class="tabItem-text"></span></a> </nav> <div class="page-content" id="listPage-content"> ', 
        startEndTicketInfoList ? ($out += ' <article class="train-list"> <ul class="list"> ', 
        $each(startEndTicketInfoList, function(startEndTicketInfo) {
            $out += " ", "0" == startEndTicketInfo.hasyp ? ($out += " ", "1" == startEndStationPojo.traintype && "P" == startEndTicketInfo.ticketType ? ($out += ' <li class="sold-out hide" time-start="', 
            $out += $escape(startEndTicketInfo.from.timeFormat), $out += '" time-end="', $out += $escape(startEndTicketInfo.to.timeFormat), 
            $out += '" data-num="', $out += $escape(startEndTicketInfo.ticketType), $out += '"> ') : ($out += ' <li class="sold-out" time-start="', 
            $out += $escape(startEndTicketInfo.from.timeFormat), $out += '" time-end="', $out += $escape(startEndTicketInfo.to.timeFormat), 
            $out += '" data-num="', $out += $escape(startEndTicketInfo.ticketType), $out += '"> '), 
            $out += ' <div class="container"> <div class="time"> <div class="start-time">', 
            $out += $escape(startEndTicketInfo.from.time), $out += '</div> <div class="end-time">', 
            $out += $escape(startEndTicketInfo.to.time), $out += '</div> </div> <div class="station"> <div class="number">', 
            $out += $escape(startEndTicketInfo.trainNumber), $out += "</div> ", "1" == startEndTicketInfo.from.first ? ($out += ' <div class="start-station">', 
            $out += $escape(startEndTicketInfo.from.name), $out += "</div> ") : ($out += ' <div class="start-station">', 
            $out += $escape(startEndTicketInfo.from.name), $out += "</div> "), $out += " ", 
            "Y" == startEndTicketInfo.to.last ? ($out += ' <div class="end-station">', $out += $escape(startEndTicketInfo.to.name), 
            $out += "</div> ") : ($out += ' <div class="end-station">', $out += $escape(startEndTicketInfo.to.name), 
            $out += "</div> "), $out += ' </div> <div class="during">', $out += $escape(startEndTicketInfo.duration), 
            $out += '</div> <div class="info"> <div class="price"> ', startEndTicketInfo.wpSeat && ($out += " <em>&yen;", 
            $out += $escape(startEndTicketInfo.wpSeat.price), $out += "</em> "), $out += ' </div> <div class="seat-type"> ', 
            startEndTicketInfo.wpSeat && ($out += " ", $out += $escape(startEndTicketInfo.wpSeat.seatTypeName), 
            $out += " "), $out += ' </div> <div class="tickets-left"> <span>无</span> </div> </div> </div> </li> ') : ($out += " ", 
            "1" == startEndStationPojo.traintype && "P" == startEndTicketInfo.ticketType ? ($out += ' <li class="hide" time-start="', 
            $out += $escape(startEndTicketInfo.from.timeFormat), $out += '" time-end="', $out += $escape(startEndTicketInfo.to.timeFormat), 
            $out += '" data-num="', $out += $escape(startEndTicketInfo.ticketType), $out += '"> ') : ($out += ' <li time-start="', 
            $out += $escape(startEndTicketInfo.from.timeFormat), $out += '" time-end="', $out += $escape(startEndTicketInfo.to.timeFormat), 
            $out += '" data-num="', $out += $escape(startEndTicketInfo.ticketType), $out += '"> '), 
            $out += ' <div class="container"> <div class="time"> <div class="start-time">', 
            $out += $escape(startEndTicketInfo.from.time), $out += '</div> <div class="end-time">', 
            $out += $escape(startEndTicketInfo.to.time), $out += '</div> </div> <div class="station"> <div class="number">', 
            $out += $escape(startEndTicketInfo.trainNumber), $out += "</div> ", "1" == startEndTicketInfo.from.first ? ($out += ' <div class="start-station">', 
            $out += $escape(startEndTicketInfo.from.name), $out += "</div> ") : ($out += ' <div class="pass-by">', 
            $out += $escape(startEndTicketInfo.from.name), $out += "</div> "), $out += " ", 
            "Y" == startEndTicketInfo.to.last ? ($out += ' <div class="end-station">', $out += $escape(startEndTicketInfo.to.name), 
            $out += "</div> ") : ($out += ' <div class="pass-by">', $out += $escape(startEndTicketInfo.to.name), 
            $out += "</div> "), $out += ' </div> <div class="during">', $out += $escape(startEndTicketInfo.duration), 
            $out += "</div> ", startEndTicketInfo.seat ? ($out += ' <div class="info"> <div class="price"> ', 
            startEndTicketInfo.seat.price && ($out += " <em>&yen;", $out += $escape(startEndTicketInfo.seat.price), 
            $out += "</em> "), $out += ' </div> <div class="seat-type"> ', startEndTicketInfo.seat.seatTypeName && ($out += " ", 
            $out += $escape(startEndTicketInfo.seat.seatTypeName), $out += " "), $out += ' </div> <div class="tickets-left"> ', 
            2 == startEndTicketInfo.seat.ypInfoCode ? ($out += " <span>", $out += $escape(startEndTicketInfo.seat.yp), 
            $out += "张</span> ") : 1 == startEndTicketInfo.seat.ypInfoCode ? ($out += ' <span class="only-left">仅剩', 
            $out += $escape(startEndTicketInfo.seat.yp), $out += "张</span> ") : $out += ' <span class="only-left">有票</span> ', 
            $out += " </div> </div> ") : ($out += ' <div class="info"> <div class="price"> ', 
            startEndTicketInfo.wpSeat && ($out += " <em>&yen;", $out += $escape(startEndTicketInfo.wpSeat.price), 
            $out += "</em> "), $out += ' </div> <div class="seat-type"> ', startEndTicketInfo.wpSeat && ($out += " ", 
            $out += $escape(startEndTicketInfo.wpSeat.seatTypeName), $out += " "), $out += ' </div> <div class="tickets-left"> <span>无</span> </div> </div> '), 
            $out += " </div> </li> "), $out += " ";
        }), $out += ' </ul> <div class="no-more">没有更多结果了</div> <input type="hidden" id="start" value="', 
        $out += $escape(startEndStationPojo.startstation), $out += '"/> <input type="hidden" id="end" value="', 
        $out += $escape(startEndStationPojo.endstation), $out += '"/> </article> ') : 0 == hasDataFlag && ($out += ' <div class="page-error-info"> 没有查到相关车次信息，可能是网络异常，请稍后重试! </div> '), 
        $out += " </div> </div>", new String($out);
    }), /*v:3*/
    template("list/relevantBus", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), Data = $data.Data, $out = "";
        return $out += ' <a class="relevantBus clearfix" href="', $out += $escape(Data.jmpUrl), 
        $out += '" data-appJmpUrl="', $out += $escape(Data.appJmpUrl), $out += '" style="display:none;"> <div class="releventBus-wrap"> <div class="relevantBus-icon"> <div class="relevantBus-icon-img"></div> <div class="relevantBus-icon-text">汽车票</div> </div> </div> <div class="releventBus-wrap"> <div class="relevantBus-travel"> <div class="relevantBus-travel-item">', 
        $out += $escape(Data.startPlaceName), $out += "-", $out += $escape(Data.destinationPlaceName), 
        $out += '</div> <div class="relevantBus-travel-item">末班:', $out += $escape(Data.lastTime), 
        $out += '</div> </div> </div> <div class="releventBus-wrap"> <div class="relevantBus-price right-triangle-icon"> <span class="relevantBus-price-num">￥', 
        $out += $escape(Data.bottomPrice), $out += '</span> <span class="relevantBus-price-text">起</span> </div> </div> </a> ', 
        new String($out);
    }), /*v:1*/
    template("login12306", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, checkCodeSwitch = $data.checkCodeSwitch, isShowHeader = $data.isShowHeader, image = $data.image, $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += "'/> ", $out += checkCodeSwitch ? ' <input type="hidden" id="checkCodeSwitchHidden" value="true"/> ' : ' <input type="hidden" id="checkCodeSwitchHidden" value="false"/> ', 
        $out += " ", isShowHeader && ($out += ' <header class="bar bar-nav" id="login12306-header"> <a class="icon icon-left-nav pull-left" id="a_f_download" data-rel="back" href=""></a> <h1 class="title">登录12306</h1> </header> '), 
        $out += ' <div class="page-content" id="login12306-content"> <ul class="login12306-wrap"> <li class="verify-wrap"> <input class="account" type="text" placeholder="请输入12306账户名"> </li> <li class="verify-wrap"> <input class="password" type="password" placeholder="请输入12306密码"/> </li> ', 
        checkCodeSwitch && ($out += ' <li class="verify-wrap verify-box clearfix"> <span>验证码</span> <em class="reload-img"></em> </li> <li class="verify-wrap verify-pic"> <div class="img-wrap"> <img class="verify-img" src="', 
        $out += $escape(image), $out += '"> <div class="imgTags"> </div> </div> </li> '), 
        $out += ' </ul> <button class="btn btn-block btn_login12306">登 录</button> <a class="reg12306" href="javascript:;">快速注册 >></a> </div> </div> ', 
        new String($out);
    }), /*v:2*/
    template("order", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, loginFlag = $data.loginFlag, insuranceChoose = $data.insuranceChoose, insruranceJSON = $data.insruranceJSON, orderFillInfo = $data.orderFillInfo, sendTicketList = $data.sendTicketList, isDefaultChooseSendTicket = $data.isDefaultChooseSendTicket, hasBonus = $data.hasBonus, noBonusForPrice = $data.noBonusForPrice, addressesJSON = $data.addressesJSON, isShowHeader = $data.isShowHeader, loginUrl = $data.loginUrl, startEndTicketInfo = $data.startEndTicketInfo, isSendTicketShow = $data.isSendTicketShow, phoneNo = $data.phoneNo, $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\'/> <input type="hidden" id="_startstation_"> <input type="hidden" id="_endstation_"> ', 
        $out += loginFlag ? ' <input type="hidden" id="loginFlag" value="true"> ' : ' <input type="hidden" id="loginFlag" value="false"> ', 
        $out += ' <input type="hidden" id="insuranceChoose" value="', $out += $escape(insuranceChoose), 
        $out += '">  <input type="hidden" id="insuranceInfoHidden" value=\'', $out += $escape(insruranceJSON), 
        $out += "'/> ", orderFillInfo && ($out += ' <input type="hidden" id="ticketTimeHidden" value="', 
        $out += $escape(orderFillInfo.startdate), $out += '"/> '), $out += ' <input type="hidden" id="insuranceInfo" value=\'', 
        $out += $escape(insruranceJSON), $out += "'> ", orderFillInfo && ($out += ' <input type="hidden" id="ticketTime" value="', 
        $out += $escape(orderFillInfo.startdate), $out += '"> '), $out += ' <input type="hidden" id="sendTicketList" value=\'', 
        $out += $escape(sendTicketList), $out += '\'> <input type="hidden" id="isDefaultChooseSendTicket" value="', 
        $out += $escape(isDefaultChooseSendTicket), $out += '"> ', $out += hasBonus ? ' <input type="hidden" id="hasBonus" value="true"> ' : ' <input type="hidden" id="hasBonus" value="false"> ', 
        $out += ' <input type="hidden" id="noBonusForPrice" value="', $out += $escape(noBonusForPrice), 
        $out += '"> ', addressesJSON ? ($out += ' <input type="hidden" id="addressesInfo" value=\'', 
        $out += $escape(addressesJSON), $out += "'> ") : $out += " ", $out += "  ", isShowHeader && ($out += ' <header class="bar bar-nav train-order-head" id="orderPage-header"> <a class="icon icon-left-nav pull-left" data-rel="back" href="/train/"></a> <h1 class="title">填写订单</h1> ', 
        loginFlag ? $out += " " : ($out += ' <a class="go-login pull-right" href="', $out += $escape(loginUrl), 
        $out += '">登录</a> '), $out += " </header> "), $out += ' <nav class="bar bar-tab order-bar"> <div class="total"> <div>￥ 0</div> <div class="totalText">订单总价</div> </div> <div class="order-detail"> <div class="order-detail-arrow"></div> <div>明细</div> </div> <div class="next"> <span>提交订单</span> </div> </nav> <div class="delivery-to bar"> </div> <div class="page-content" id="orderPage-content"> <article class="train-order-page clearfix"> ', 
        startEndTicketInfo && ($out += ' <section class="info"> <div class="clearfix"> <div class="start"> <div class="station j-startstation">', 
        $out += $escape(startEndTicketInfo.from.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.from.time), $out += "</div> ", orderFillInfo && ($out += ' <div class="date">', 
        $out += $escape(orderFillInfo.startDateStr), $out += "</div> "), $out += ' </div> <div class="train"> <div class="during">历时', 
        $out += $escape(startEndTicketInfo.duration), $out += '</div> <div class="schedule"> <div class="schedule-left"></div> <div class="schedule-content">列车时刻表</div> <div class="schedule-right"></div> </div> ', 
        orderFillInfo && ($out += ' <div class="coach">', $out += $escape(orderFillInfo.trainNum), 
        $out += "</div> "), $out += ' </div> <div class="end"> <div class="station j-endstation">', 
        $out += $escape(startEndTicketInfo.to.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.to.time), $out += '</div> <div class="date">', 
        $out += $escape(orderFillInfo.endDateStr), $out += '</div> </div> </div> </section> <div class="section seat-type-wrap"> <span class="seat-info">已选座席</span> <span class="seat-info seat-type" data-seat-code="', 
        $out += $escape(startEndTicketInfo.seat.seatTypeCode), $out += '" data-seat-price="', 
        $out += $escape(startEndTicketInfo.seat.price), $out += '"> ', $out += $escape(startEndTicketInfo.seat.seatTypeName), 
        $out += ' </span>  <span class="seat-info seat-price"> ￥', $out += $escape(startEndTicketInfo.seat.price), 
        $out += ' </span> </div> <div class="user"> <div class="section add-people"> <div class="add-adult">添加乘车人</div> <div class="spit-line"></div> <div class="add-child">添加儿童票</div> </div> <ul class="people-list"> </ul> </div> ', 
        $out += "1" == isSendTicketShow ? ' <div class="section choose-seat j-choose-seat"> <div class="set-seat"><span class="title-span">我要选座</span> <span class="chosen-seat" value="inAdjacent" data-seat-type="0"> </span> </div> <div class="seat-detail hide"> <div class="set-num"> <span class="seat-detail-text">至少需要</span> <div class="set-num-area"> <span class="minus">&nbsp;</span> <span class="count">1</span> <span class="plus">&nbsp;</span> </div> <span class="seat-detail-text">张</span> <em class="set-ticket-type">下铺</em> <span class="seat-detail-text">票</span> </div> </div> <div class="yield-seat hide"> <span class="title-span">当指定卧铺无票时，接受中上铺</span> <label class="label-checkbox"> <div class="checkbox"></div> </label> </div> </div> <div class="to-delivery section hide j-to-delivery"> <span class="title-span">配送地址</span> <span class="post-tips">请选择配送地址</span> </div> <div class="deliveryInfo"> </div> ' : " ", 
        $out += ' <div class="phone-info section"> <label for="order-mobile" class="title-span">手机</label> <input id="order-mobile" type="tel" placeholder="用于接收出票短信" maxlength="11" value="', 
        $out += $escape(phoneNo), $out += '"> <div class="phone-info-icon"></div> </div> <div class="section"> <div class="inSureSwitch forInsure"> <span class="title-span">保险</span><span class="insure-num">交通意外险 20元X0份</span> </div>  <div class="inSureSwitch forReceipt"> <span class="title-span">保险发票</span> <span class="need-receipt" data-needreceipt="0">不需要</span> </div>  </div>  <div class="redPacket" data-isUser="false" data-id="" data-price="0"> <span class="redPacket-title">优惠</span> ', 
        "true" == loginFlag ? ($out += " ", $out += "true" == hasBonus ? ' <span class="redPacket-text">请选择要使用的优惠券</span> ' : ' <span class="redPacket-text"> 您没有可使用的优惠券 </span> ', 
        $out += " ") : $out += ' <span class="redPacket-text">登录后可使用</span> ', $out += " </div>  ", 
        "1" == isSendTicketShow && ($out += ' <div class="ticket-tips hide"> 配送票不支持在线退票、改签，如需退票、改签，请在发车前凭有效证件到火车站办理。 </div> '), 
        $out += " "), $out += " </article> </div>  </div> ", new String($out);
    }), /*v:4*/
    template("order/activityPlugin", '<div class="activityPlugin page-on-right page-plugin"> <header class="bar bar-nav"> <a class="icon icon-left-nav pull-left j-back"></a> <h1 class="title"></h1> <div class="explain"></div> </header> <div class="page-content"> <iframe class="activity-page" style="width: 100%;height: 100%;border: none;"></iframe> </div> </div>'), 
    /*v:1*/
    template("order/addPeoplePlugin", '<div class="person-list page-on-right page-plugin"> <header class="bar bar-nav"><a class="icon icon-left-nav pull-left"></a> <h1 class="title">选择乘客</h1></header> <div class="page-content"> <ul class="table-view add-people-list"> <li class="table-view-cell right-triangle-icon to-add-people"> <span class="people-text">新增乘车人</span> </li> </ul> </div> <nav class="bar bar-tab"> <button type="button" class="btn btn-primary btn-block add-passenger">确定</button> </nav> </div> '), 
    /*v:1*/
    template("order/editPeopleInfoPlugin", '<div class="edit-people-info page-on-right page-plugin"> <header class="bar bar-nav"><a class="icon icon-left-nav pull-left"></a> <h1 class="title">编辑乘客</h1></header> <div class="page-content" style="z-index: 9995;"> <form class="input-group "> <div class="input-row button-line"> <label for="order-name">乘客姓名</label> <input id="order-name" type="text" class="name"> <div class="triangle-right-buttom"></div> </div> <div class="input-row button-line"> <label for="order-cert-type">证件类型</label> <input id="order-cert-type" type="text" class="cert-type" readonly="readonly"> <div class="triangle-right-buttom"></div> </div> <div class="input-row button-line"> <label for="order-cert-number">证件号码</label> <input id="order-cert-number" type="text" class="cert-number"> <div class="triangle-right-buttom"></div> </div> <div class="input-row button-line" style="display:none;"> <label for="order-cert-day" style="width: 100%;z-index:2;">出生日期</label> <input id="order-cert-day" readonly="readonly" placeholder="请选择您的出生日期" type="text" class="cert-day" style="position:absolute;right: 0px;z-index:1"> <div class="triangle-right-buttom"></div> </div> </form> </div> <nav class="bar bar-tab"> <button type="button" class="btn btn-primary btn-block add-passenger">完成</button> </nav> </div> '), 
    /*v:1*/
    template("order/insurancePlugin", '<div class="insurance-wrapper page-plugin page-on-right"> <header class="bar bar-nav"><a class="icon icon-back pull-left"></a> <h1 class="title">保险</h1></header> <ul class="insure-body"> <li data="1" class="active"> <div class="insure-name"><span class="insureName">{insureName}</span><span class="insure-illustrates"></span><span>20元/份</span></div> <div class="insure-info">推荐选择，安全出行，最高保额80万</div> </li> <li data="0"> <div class="insure-name">不购买保险</div> <div class="insure-info">普通购票，预订人数较多时可能会排队</div> </li> </ul> <p class="insure-remind">当前购票人数较多，建议您选择保险，快速出票， 出行有保障</p> <nav class="bar bar-tab"> <button type="button" class="btn btn-primary btn-block filled">确定</button> </nav> </div> '), 
    /*v:1*/
    template("order/redPacketPlugin", '<div class="redPacketPlugin page-on-right page-plugin"> <header class="bar bar-nav"> <a class="icon icon-left-nav pull-left j-back"></a> <h1 class="title">选择优惠</h1> <div class="explain"></div> </header> <div class="page-content"> <div class="notuse" data-id="0" data-price="-1"> 不使用优惠               </div> <div class="list">                                       </div> </div> </div> '), 
    /*v:1*/
    template("order/redPacketPlugin_item", function($data) {
        "use strict";
        var $utils = this, $each = ($utils.$helpers, $utils.$each), Data = $data.Data, $escape = ($data.redPacket, 
        $data.$index, $utils.$escape), $out = "";
        return $each(Data, function(redPacket) {
            $out += ' <div class="list-item clearfix ', $out += $escape(redPacket.labelRadioState), 
            $out += '" data-id="', $out += $escape(redPacket.incomeDiscountId), $out += '" data-price="', 
            $out += $escape(redPacket.singleAmount), $out += '"> <div class="itemWrap_left"> ', 
            $out += $escape(redPacket.singleAmount), $out += ' </div> <div class="itemWrap_right"> <div class="itemTitle">', 
            $out += $escape(redPacket.title), $out += '</div> <div class="itemRest">有效期还剩', 
            $out += $escape(redPacket.effectiveRemainDay), $out += '天</div> <div class="itemDate">', 
            $out += $escape(redPacket.effectiveBeginEndTimeExplain), $out += '</div> </div> <div class="expired"></div> <!--<label class="label-radio label-radio_redPacket ', 
            $out += $escape(redPacket.labelRadioState), $out += '"-->  <!--data-id="', $out += $escape(redPacket.incomeDiscountId), 
            $out += '"--> <!--data-price="', $out += $escape(redPacket.singleAmount), $out += '">-->   <!--<div class="redPacket clearfix ', 
            $out += $escape(redPacket.redPacketState), $out += '">-->  <!--<div class="redPacket-info-item">', 
            $out += $escape(redPacket.title), $out += '</div>--> <!--<div class="redPacket-info-item">有效期还剩', 
            $out += $escape(redPacket.effectiveRemainDay), $out += '天</div>--> <!--<div class="redPacket-info-item">有效期至', 
            $out += $escape(redPacket.effectiveEndTime), $out += '</div>-->    <!--<span class="redPacket-price-number">', 
            $out += $escape(redPacket.singleAmount), $out += "</span>-->      </div> ";
        }), new String($out);
    }), /*v:3*/
    template("order12306", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, loginFlag = $data.loginFlag, insuranceChoose = $data.insuranceChoose, insruranceJSON = $data.insruranceJSON, orderFillInfo = $data.orderFillInfo, sendTicketList = $data.sendTicketList, isDefaultChooseSendTicket = $data.isDefaultChooseSendTicket, hasBonus = $data.hasBonus, noBonusForPrice = $data.noBonusForPrice, isCtrip12306 = $data.isCtrip12306, randCodeSwitch = $data.randCodeSwitch, addressesJSON = $data.addressesJSON, isShowHeader = $data.isShowHeader, loginUrl = $data.loginUrl, startEndTicketInfo = $data.startEndTicketInfo, phoneNo = $data.phoneNo, image = $data.image, isSendTicketShow = $data.isSendTicketShow, $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\'/> <input type="hidden" id="_startstation_"> <input type="hidden" id="_endstation_"> ', 
        $out += loginFlag ? ' <input type="hidden" id="loginFlag" value="true"> ' : ' <input type="hidden" id="loginFlag" value="false"> ', 
        $out += ' <input type="hidden" id="insuranceChoose" value="', $out += $escape(insuranceChoose), 
        $out += '">  <input type="hidden" id="insuranceInfoHidden" value=\'', $out += $escape(insruranceJSON), 
        $out += "'/> ", orderFillInfo && ($out += ' <input type="hidden" id="ticketTimeHidden" value="', 
        $out += $escape(orderFillInfo.startdate), $out += '"/> '), $out += ' <input type="hidden" id="insuranceInfo" value=\'', 
        $out += $escape(insruranceJSON), $out += "'> ", orderFillInfo && ($out += ' <input type="hidden" id="ticketTime" value="', 
        $out += $escape(orderFillInfo.startdate), $out += '"> '), $out += ' <input type="hidden" id="sendTicketList" value=\'', 
        $out += $escape(sendTicketList), $out += '\'> <input type="hidden" id="isDefaultChooseSendTicket" value="', 
        $out += $escape(isDefaultChooseSendTicket), $out += '"> ', $out += hasBonus ? ' <input type="hidden" id="hasBonus" value="true"> ' : ' <input type="hidden" id="hasBonus" value="false"> ', 
        $out += ' <input type="hidden" id="noBonusForPrice" value="', $out += $escape(noBonusForPrice), 
        $out += '"> <input type="hidden" id="isCtrip12306" value="', $out += $escape(isCtrip12306), 
        $out += '"> <input type="hidden" id="randCodeSwitch" value=\'', $out += $escape(randCodeSwitch), 
        $out += "'> ", addressesJSON ? ($out += ' <input type="hidden" id="addressesInfo" value=\'', 
        $out += $escape(addressesJSON), $out += "'> ") : $out += " ", $out += "  ", isShowHeader && ($out += ' <header class="bar bar-nav train-order-head" id="orderPage-header"> <a class="icon icon-left-nav pull-left" data-rel="back" href="/train/"></a> <h1 class="title">填写订单</h1> ', 
        loginFlag ? $out += " " : ($out += ' <a class="go-login pull-right" href="', $out += $escape(loginUrl), 
        $out += '">登录</a> '), $out += " </header> "), $out += ' <nav class="bar bar-tab order-bar"> <div class="total"> <div>￥ 0</div> <div class="totalText">订单总价</div> </div> <div class="order-detail"> <div class="order-detail-arrow"></div> <div>明细</div> </div> <div class="next"> <span>提交订单</span> </div> </nav> <div class="delivery-to bar"> </div> <div class="page-content" id="orderPage-content"> <article class="train-order-page clearfix"> ', 
        startEndTicketInfo && ($out += ' <section class="info"> <div class="clearfix"> <div class="start"> <div class="station j-startstation">', 
        $out += $escape(startEndTicketInfo.from.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.from.time), $out += '</div> <div class="date">', 
        $out += $escape(orderFillInfo.startDateStr), $out += '</div> </div> <div class="train"> <div class="during">历时', 
        $out += $escape(startEndTicketInfo.duration), $out += '</div> <div class="schedule"> <div class="schedule-left"></div> <div class="schedule-content">列车时刻表</div> <div class="schedule-right"></div> </div> <div class="coach">', 
        $out += $escape(orderFillInfo.trainNum), $out += '</div> </div> <div class="end"> <div class="station j-endstation">', 
        $out += $escape(startEndTicketInfo.to.name), $out += '</div> <div class="time">', 
        $out += $escape(startEndTicketInfo.to.time), $out += '</div> <div class="date">', 
        $out += $escape(orderFillInfo.endDateStr), $out += '</div> </div> </div> </section> <div class="section seat-type-wrap"> <span class="seat-info">已选座席</span> <span class="seat-info seat-type" data-seat-code="', 
        $out += $escape(startEndTicketInfo.seat.seatTypeCode), $out += '" data-seat-price="', 
        $out += $escape(startEndTicketInfo.seat.price), $out += '">', $out += $escape(startEndTicketInfo.seat.seatTypeName), 
        $out += ' </span>  <span class="seat-info seat-price"> ￥', $out += $escape(startEndTicketInfo.seat.price), 
        $out += ' </span> </div> <div class="user"> <div class="section add-people"> <div class="add-adult">添加乘车人</div> <div class="spit-line"></div> <div class="add-child">添加儿童票</div> </div> <ul class="people-list"> </ul> </div> <div class="phone-info section"> <label for="order-mobile" class="title-span">手机</label> <input id="order-mobile" type="tel" placeholder="用于接收出票短信" maxlength="11" value="', 
        $out += $escape(phoneNo), $out += '"> <div class="phone-info-icon"></div> </div> <div class="section"> <div class="inSureSwitch forInsure"> <span class="title-span">保险</span> <span class="insure-num">交通意外险 20元X0份</span> </div>  <div class="inSureSwitch forReceipt"> <span class="title-span">保险发票</span> <span class="need-receipt" data-needreceipt="0">不需要</span> </div>  </div>  <div class="redPacket" data-isUser="false" data-id="" data-price="0"> <span class="redPacket-title">优惠</span> ', 
        "true" == loginFlag ? ($out += " ", $out += "true" == hasBonus ? ' <span class="redPacket-text">请选择要使用的优惠券</span> ' : ' <span class="redPacket-text"> 您没有可使用的优惠券 </span> ', 
        $out += " ") : $out += ' <span class="redPacket-text">登录后可使用</span> ', $out += " </div>   ", 
        "OFF" != randCodeSwitch && ($out += ' <div class="getrandcode section"> <div class="getrandcode-header"> <span class="title-span">验证码</span> <span class="getrandcode-icon"></span> </div> <div class="getrandcode-body"> <img class="getrandcode-img" src="', 
        $out += $escape(image), $out += '"> <div class="getrandcode-tags"> </div> </div> </div> '), 
        $out += "  ", "1" == isSendTicketShow && ($out += ' <div class="ticket-tips hide"> 配送票不支持在线退票、改签，如需退票、改签，请在发车前凭有效证件到火车站办理。 </div> '), 
        $out += " "), $out += " </article> </div>  </div> ", new String($out);
    }), /*v:8*/
    template("orderdetail", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, bonusAmount = $data.bonusAmount, orderDetailInfo = $data.orderDetailInfo, isNeedLogin12306 = $data.isNeedLogin12306, cancel12306ctripOrder = $data.cancel12306ctripOrder, sendTicketUrl = $data.sendTicketUrl, connectionMobile = $data.connectionMobile, isShowHeader = $data.isShowHeader, startDateStr = $data.startDateStr, endDateStr = $data.endDateStr, $each = $utils.$each, hasDataFlag = ($data.ticketOrderInfo, 
        $data.$index, $data.hasDataFlag), $out = "";
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += '\'/> <input type="hidden" id="hiddenBonusPrice" value=\'', 
        $out += $escape(bonusAmount), $out += "'/> ", orderDetailInfo && ($out += ' <input type="hidden" id="payDeadLine" value="', 
        $out += $escape(orderDetailInfo.payDeadLine), $out += '"/> '), $out += ' <input type="hidden" id="isNeedLogin12306" value=\'', 
        $out += $escape(isNeedLogin12306), $out += '\'/> <input type="hidden" id="cancel12306ctripOrder" value=\'', 
        $out += $escape(cancel12306ctripOrder), $out += '\'/> <input type="hidden" id="sendTicketUrl" value=\'', 
        $out += $escape(sendTicketUrl), $out += "'/> ", orderDetailInfo && ($out += ' <input type="hidden" id="trainUserName" value=\'', 
        $out += $escape(orderDetailInfo.trainUserName), $out += "'/> "), $out += " ", connectionMobile && ($out += ' <input type="hidden" id="connectionMobile" value="', 
        $out += $escape(connectionMobile), $out += '"> '), $out += "  ", isShowHeader && ($out += ' <header class="bar bar-nav "> <a class="icon icon-left-nav pull-left data-rel-back-" data-rel=back href="JavaScript:void(0);"></a> <h1 class="title">订单详情</h1> <a class="pull-right order-detail-reload" href="#">刷新</a> </header> '), 
        $out += "  ", orderDetailInfo && "001" == orderDetailInfo.appStatus ? ($out += ' <nav class="bar bar-tab order-bar" id="orderDetailPage-footer"> <div class="total"> <div class="total-value"> ￥', 
        $out += $escape(orderDetailInfo.orderPrice), $out += ' </div> <div class="totalText">订单总价</div> </div> <div class="order-detail"> <div class="order-detail-arrow"></div> <div>明细</div> </div> <div class="next"> <span>去支付</span> </div> </nav> ') : orderDetailInfo && "008" == orderDetailInfo.appStatus ? $out += '  <nav class="bar bar-tab" id="orderDetailPage-footer"> <a class="btn btn-block btn-primary continueButton">继续预订</a> </nav>  ' : !orderDetailInfo || "006" != orderDetailInfo.appStatus && "007" != orderDetailInfo.appStatus ? orderDetailInfo && "004" == orderDetailInfo.appStatus ? $out += ' <nav class="bar bar-tab" id="orderDetailPage-footer"> <a class="btn btn-block btn-primary reloadButton">刷新占座进度</a> </nav> ' : !orderDetailInfo || "005" != orderDetailInfo.appStatus && "002" != orderDetailInfo.appStatus && "003" != orderDetailInfo.appStatus && "009" != orderDetailInfo.appStatus ? $out += " " : ($out += '  <nav class="bar bar-tab clearfix" id="orderDetailPage-footer"> ', 
        "1" == orderDetailInfo.isVerifyFailure ? ($out += ' <a class="btn btn-left">送票上门</a> ', 
        $out += "1" == orderDetailInfo.cancel12306Order ? ' <a class="btn btn-right btn-qxbcxyd">取消并重新预订</a> ' : ' <a class="btn btn-right">重新预订</a> ', 
        $out += " ") : ($out += ' <a class="btn btn-block btn-primary againButton"> ', $out += "1" == orderDetailInfo.cancel12306Order ? " 取消并重新预订 " : " 重新预订 ", 
        $out += " </a> "), $out += " </nav> ") : $out += '  <nav class="bar bar-tab" id="orderDetailPage-footer"> <a class="btn btn-block btn-primary reloadButton">刷新出票进度</a> </nav>  ', 
        $out += '  <div class="page-content" id="orderDetailPage-content"> <div class="orderDetailPage-content"> ', 
        orderDetailInfo ? ($out += '  <div class="order-pay-info"> <div class="pay-title"> <span style="color: ', 
        $out += $escape(orderDetailInfo.appStatusColor), $out += "; background-image: url(", 
        $out += $escape(orderDetailInfo.appStatusIcon), $out += ');">', $out += $escape(orderDetailInfo.appStatusName), 
        $out += "</span> </div> ", !orderDetailInfo || "001" != orderDetailInfo.appStatus || "4" != orderDetailInfo.mode && "32" != orderDetailInfo.mode ? ($out += ' <div class="pay-message"> ', 
        $out += $escape(orderDetailInfo.universalTips), $out += " </div> ") : ($out += '  <div class="pay-message"> <span>请在</span> ', 
        orderDetailInfo && ($out += ' <span class="pay-message-time">', $out += $escape(orderDetailInfo.payDeadLine), 
        $out += "</span> "), $out += " <span>内完成支付,取票号:</span> <span>", $out += $escape(orderDetailInfo.orderId_12306), 
        $out += "</span> </div> "), $out += ' </div>   <div class="train-timetable"> <div class="clearfix"> <div class="start"> <div class="station">', 
        $out += $escape(orderDetailInfo.startStationName), $out += '</div> <div class="time">', 
        $out += $escape(orderDetailInfo.startTimeClock), $out += '</div> <div class="date">', 
        $out += $escape(orderDetailInfo.startTimeMonth), $out += "月", $out += $escape(orderDetailInfo.startTimeDay), 
        $out += "日 ", $out += $escape(startDateStr), $out += '</div> </div> <div class="train"> <div class="during">', 
        $out += $escape(orderDetailInfo.timeLength), $out += '</div> <div class="schedule"> <div class="schedule-left"></div> <div class="schedule-content">列车时刻表</div> <div class="schedule-right"></div> </div> <div class="coach">', 
        $out += $escape(orderDetailInfo.trainNumber), $out += '</div> </div> <div class="end"> <div class="station">', 
        $out += $escape(orderDetailInfo.endStationName), $out += '</div> <div class="time">', 
        $out += $escape(orderDetailInfo.endTimeClock), $out += '</div> <div class="date">', 
        $out += $escape(orderDetailInfo.endTimeMonth), $out += "月", $out += $escape(orderDetailInfo.endTimeDay), 
        $out += "日 ", $out += $escape(endDateStr), $out += '</div> </div> </div> </div>   <div class="order-list"> <input type="hidden" value="', 
        $out += $escape(orderDetailInfo.fees), $out += '" id="fees"/> <input type="hidden" value="', 
        $out += $escape(orderDetailInfo.deliverCost), $out += '" id="deliverCost"/> <ul>     ', 
        $each(orderDetailInfo.ticketOrderList, function(ticketOrderInfo) {
            $out += ' <li class="order-item" data-orderItemId="', $out += $escape(ticketOrderInfo.orderItemId), 
            $out += '" data-price="', $out += $escape(ticketOrderInfo.price), $out += '" data-seat="', 
            $out += $escape(orderDetailInfo.seatTypeName), $out += '" data-isinsurance="', $out += $escape(ticketOrderInfo.isHaveInsurance), 
            $out += '"> <div class="item1"> <div class="name"> <span>', $out += $escape(ticketOrderInfo.name), 
            $out += '</span> </div> <div class="ticket-type"> <span class="ticket-type-name">', 
            $out += $escape(ticketOrderInfo.ticketTypeName), $out += '</span> <span class="ticket-type-paper">', 
            $out += $escape(ticketOrderInfo.certTypeName), $out += "</span> ", $out += "1" == ticketOrderInfo.isHaveInsurance ? "  " : " ", 
            $out += ' </div> <div class="ticket-state"> ', "0" == orderDetailInfo.orderStatus || "6" == orderDetailInfo.orderStatus || "7" == orderDetailInfo.orderStatus ? ($out += ' <span style="color: ', 
            $out += $escape(orderDetailInfo.appStatusColor), $out += ';">', $out += $escape(orderDetailInfo.appStatusName), 
            $out += "</span> ") : ($out += ' <span style="color: ', $out += $escape(orderDetailInfo.appStatusColor), 
            $out += ';">', $out += $escape(ticketOrderInfo.ticketStatusName), $out += "</span> "), 
            $out += ' </div> </div> <div class="item2"> <div class="seat-grade"> <span>', $out += $escape(orderDetailInfo.seatTypeName), 
            $out += '</span> </div> <div class="price"> <span>￥', $out += $escape(ticketOrderInfo.price), 
            $out += "</span> </div> </div> ", ("1" == ticketOrderInfo.isUnsubscribe || ticketOrderInfo.seatNumber && "" != ticketOrderInfo.seatNumber) && ($out += ' <div class="item3"> <div class="seat-no"> <span>', 
            $out += $escape(ticketOrderInfo.seatNumber), $out += "</span> </div> ", "1" == ticketOrderInfo.isUnsubscribe && ($out += ' <div class="operation"> <a class="ticket-return">退票</a> </div> '), 
            $out += " </div> "), $out += " </li> ";
        }), $out += ' </ul> </div>   <div class="order-info j-shrink"> <header> <h4>订单信息</h4> <i class="icon icon-top"></i> </header> <div class="order-content" style="display: block;"> <div class="content-tel"> <span class="label">联系电话</span> <span class="text">', 
        $out += $escape(orderDetailInfo.contactMobile), $out += '</span> </div> <div class="content-no"> <span class="label">订单号</span> <span class="text">', 
        $out += $escape(orderDetailInfo.orderId), $out += '</span> </div> <div class="content-time"> <span class="label">下单时间</span> <span class="text">', 
        $out += $escape(orderDetailInfo.orderDate), $out += "</span> </div> </div> </div>   ", 
        orderDetailInfo.insuranceCompanyName && ($out += ' <div class="insurance j-expand"> <header> <h4>保险信息</h4> <i class="icon icon-bottom"></i> </header> <div class="order-content"> <div class="content-money"> <span class="label">保险金额</span> <span class="text">￥', 
        $out += $escape(orderDetailInfo.insuranceTotalAmount), $out += '</span> </div> <div class="content-tel"> <span class="label">保险电话</span> <span class="text">', 
        $out += $escape(orderDetailInfo.insuranceCompanyTel), $out += '</span> </div> <div class="content-company"> <span class="label">保险公司</span> <span class="text">', 
        $out += $escape(orderDetailInfo.insuranceCompanyName), $out += "</span> </div> </div> </div> "), 
        $out += "   ", orderDetailInfo.personalDetails && ($out += ' <div class="seat-select j-expand"> <header> <h4>我要选座信息</h4> <i class="icon icon-bottom"></i> </header> <div class="order-content"> <div class="content-detail"> <span class="label">定制详情</span> <span class="text">', 
        $out += $escape(orderDetailInfo.personalDetails), $out += '</span> </div> <div class="content-tel"> <span class="label">联系电话</span> <span class="text">', 
        $out += $escape(orderDetailInfo.contactMobile), $out += '</span> </div> <div class="content-address"> <span class="label">配送地址</span> ', 
        orderDetailInfo.addressInfo && ($out += ' <span class="text">', $out += $escape(orderDetailInfo.addressInfo), 
        $out += "</span> "), $out += " </div> </div> </div>  "), $out += '  <div class="order-total"> <header> <h4>订单总额: <span>￥', 
        $out += $escape(orderDetailInfo.orderPrice), $out += "</span> </h4> </header> </div>  ", 
        $out += "0" == orderDetailInfo.orderStatus || "1" == orderDetailInfo.orderStatus || "7" == orderDetailInfo.orderStatus ? '  <div class="cancelOrder"> <a class="cancelOrderBtn">取消订单</a> </div>  ' : " ", 
        $out += " ") : 0 == hasDataFlag && ($out += ' <div class="page-error-info"> 您查找的订单不存在！亲 </div> '), 
        $out += ' </div> </div>  <div class="time-list page-plugin plugin-inited"> <div class="bar bar-nav"> <div class="time-list-close">关闭</div> </div> <div class="page-content"> <div class="list-title">列车时刻表</div> </div> </div>   ', 
        orderDetailInfo && ($out += ' <input type="hidden" id="gorderId" value="', $out += $escape(orderDetailInfo.gorderId), 
        $out += '"> '), $out += " ", orderDetailInfo && ($out += ' <input type="hidden" id="orderId" value=\'', 
        $out += $escape(orderDetailInfo.orderId), $out += "'/> "), $out += " </div>", new String($out);
    }), /*v:5*/
    template("orderlist", function($data) {
        "use strict";
        var $utils = this, $escape = ($utils.$helpers, $utils.$escape), sys = $data.sys, contectPhone = $data.contectPhone, isShowHeader = $data.isShowHeader, loginFlag = $data.loginFlag, hasDataFlag = $data.hasDataFlag, orderListInfo = $data.orderListInfo, $each = $utils.$each, $out = ($data.orderInfo, 
        $data.$index, "");
        return $out += '<div class="page"> <input type="hidden" id="sysHidden" value=\'', 
        $out += $escape(sys), $out += "' />  ", contectPhone ? ($out += ' <input type="hidden" id = "connectionMobile" value="', 
        $out += $escape(contectPhone), $out += '"> ') : $out += " ", $out += " ", isShowHeader && ($out += ' <header class="bar bar-nav train-order-head"> <a class="icon icon-left-nav pull-left data-rel-back-" data-rel="back" href="JavaScript:void(0);"></a> <h1 class="title">火车票订单列表页</h1> ', 
        loginFlag || ($out += ' <span class="list-login-btn">登录</span> '), $out += " </header> "), 
        $out += ' <div class="page-content" id="orderlistPage-content"> ', 0 == hasDataFlag ? $out += ' <div class="list-nodata-box"> 您当前没有火车票订单 <div class="list-book-btn">立即订火车票</div> </div> ' : orderListInfo && ($out += ' <article class="train-order"> <ul class="orderlist">   ', 
        $each(orderListInfo, function(orderInfo) {
            $out += " ", "0" == orderInfo.orderStatus || "7" == orderInfo.orderStatus ? ($out += ' <li class="pay-waiting" data-gorder-id="', 
            $out += $escape(orderInfo.gorderId), $out += '" data-order-id="', $out += $escape(orderInfo.orderId), 
            $out += '" data-order-type="1" data-need-login-12306="', $out += $escape(orderInfo.isNeedLogin12306), 
            $out += '" data-trainUserName="', $out += $escape(orderInfo.trainUserName), $out += '"> <header class="clearfix"> <div class="pay-state"> <span class="pay-state-text">', 
            $out += $escape(orderInfo.appStatusName), $out += '</span> </div> <div class="order-number"> ', 
            $out += $escape(orderInfo.orderId), $out += " </div> ", $out += "1" == orderInfo.is12306 ? ' <div class="order-type"> <i class="logo-icon-12306"></i> <span> 12306订单 </span> </div> ' : ' <div class="order-type"> <i class="logo-icon-elong"></i> <span> 艺龙订单 </span> </div> ', 
            $out += ' </header> <div class="content clearfix"> <div class="train-info"> <div class="train-info-first"> <span class="order-date">', 
            $out += $escape(orderInfo.trainStartMonth), $out += "月", $out += $escape(orderInfo.trainStartDay), 
            $out += '日</span> <span class="order-station">', $out += $escape(orderInfo.startStationName), 
            $out += " - ", $out += $escape(orderInfo.endStationName), $out += '</span> </div> <div class="train-info-second"> <span class="train-time">', 
            $out += $escape(orderInfo.trainStartClock), $out += "-", $out += $escape(orderInfo.trainEndClock), 
            $out += '</span> <span class="train-no">', $out += $escape(orderInfo.trainNo), $out += '</span> </div> </div> <div class="train-price"> ￥', 
            $out += $escape(orderInfo.orderPrice), $out += ' <i class="icon icon-next"></i> </div> </div> <footer> <a class="cancel">取消</a> <a class="pay">去支付</a> </footer> </li> ') : "5" == orderInfo.orderStatus ? ($out += ' <li class="pay-cancel" data-gorder-id="', 
            $out += $escape(orderInfo.gorderId), $out += '" data-order-type="2" data-need-login-12306="', 
            $out += $escape(orderInfo.isNeedLogin12306), $out += '"> <header class="clearfix"> <div class="pay-state"> <span class="pay-state-text">', 
            $out += $escape(orderInfo.appStatusName), $out += '</span> </div> <div class="order-number"> ', 
            $out += $escape(orderInfo.orderId), $out += " </div> ", $out += "1" == orderInfo.is12306 ? ' <div class="order-type"> <i class="logo-icon-12306"></i> <span> 12306订单 </span> </div> ' : ' <div class="order-type"> <i class="logo-icon-elong"></i> <span> 艺龙订单 </span> </div> ', 
            $out += ' </header> <div class="content clearfix"> <div class="train-info"> <div class="train-info-first"> <span class="order-date">', 
            $out += $escape(orderInfo.trainStartMonth), $out += "月", $out += $escape(orderInfo.trainStartDay), 
            $out += '日</span> <span class="order-station">', $out += $escape(orderInfo.startStationName), 
            $out += " - ", $out += $escape(orderInfo.endStationName), $out += '</span> </div> <div class="train-info-second"> <span class="train-time">', 
            $out += $escape(orderInfo.trainStartClock), $out += "-", $out += $escape(orderInfo.trainEndClock), 
            $out += '</span> <span class="train-no">', $out += $escape(orderInfo.trainNo), $out += '</span> </div> </div> <div class="train-price"> ￥', 
            $out += $escape(orderInfo.orderPrice), $out += ' <i class="icon icon-next"></i> </div> </div> </li> ') : "2" == orderInfo.orderStatus ? ($out += ' <li class="pay-ticketed" data-gorder-id="', 
            $out += $escape(orderInfo.gorderId), $out += '" data-order-type="4" data-need-login-12306="', 
            $out += $escape(orderInfo.isNeedLogin12306), $out += '"> <header class="clearfix"> <div class="pay-state"> <span class="pay-state-text">', 
            $out += $escape(orderInfo.appStatusName), $out += '</span> </div> <div class="order-number"> ', 
            $out += $escape(orderInfo.orderId), $out += " </div> ", $out += "1" == orderInfo.is12306 ? ' <div class="order-type"> <i class="logo-icon-12306"></i> <span> 12306订单 </span> </div> ' : ' <div class="order-type"> <i class="logo-icon-elong"></i> <span> 艺龙订单 </span> </div> ', 
            $out += ' </header> <div class="content clearfix"> <div class="train-info"> <div class="train-info-first"> <span class="order-date">', 
            $out += $escape(orderInfo.trainStartMonth), $out += "月", $out += $escape(orderInfo.trainStartDay), 
            $out += '日</span> <span class="order-station">', $out += $escape(orderInfo.startStationName), 
            $out += " - ", $out += $escape(orderInfo.endStationName), $out += '</span> </div> <div class="train-info-second"> <span class="train-time">', 
            $out += $escape(orderInfo.trainStartClock), $out += "-", $out += $escape(orderInfo.trainEndClock), 
            $out += '</span> <span class="train-no">', $out += $escape(orderInfo.trainNo), $out += '</span> </div> </div> <div class="train-price"> ￥', 
            $out += $escape(orderInfo.orderPrice), $out += ' <i class="icon icon-next"></i> </div> </li> ') : ($out += ' <li class="pay-ticketing" data-gorder-id="', 
            $out += $escape(orderInfo.gorderId), $out += '" data-order-type="3" data-need-login-12306="', 
            $out += $escape(orderInfo.isNeedLogin12306), $out += '"> <header class="clearfix"> <div class="pay-state"> <span class="pay-state-text">', 
            $out += $escape(orderInfo.appStatusName), $out += '</span> </div> <div class="order-number"> ', 
            $out += $escape(orderInfo.orderId), $out += " </div> ", $out += "1" == orderInfo.is12306 ? ' <div class="order-type"> <i class="logo-icon-12306"></i> <span> 12306订单 </span> </div> ' : ' <div class="order-type"> <i class="logo-icon-elong"></i> <span> 艺龙订单 </span> </div> ', 
            $out += ' </header> <div class="content clearfix"> <div class="train-info"> <div class="train-info-first"> <span class="order-date">', 
            $out += $escape(orderInfo.trainStartMonth), $out += "月", $out += $escape(orderInfo.trainStartDay), 
            $out += '日</span> <span class="order-station">', $out += $escape(orderInfo.startStationName), 
            $out += " - ", $out += $escape(orderInfo.endStationName), $out += '</span> </div> <div class="train-info-second"> <span class="train-time">', 
            $out += $escape(orderInfo.trainStartClock), $out += "-", $out += $escape(orderInfo.trainEndClock), 
            $out += '</span> <span class="train-no">', $out += $escape(orderInfo.trainNo), $out += '</span> </div> </div> <div class="train-price"> ￥', 
            $out += $escape(orderInfo.orderPrice), $out += ' <i class="icon icon-next"></i> </div> </div> </li> '), 
            $out += " ";
        }), $out += " </ul> </article> "), $out += " </div> </div>", new String($out);
    }), /*v:1*/
    template("regist12306", function($data) {
        "use strict";
        var $utils = this, isShowHeader = ($utils.$helpers, $data.isShowHeader), $out = "";
        return $out += '<div class="page">  ', isShowHeader && ($out += ' <header class="bar bar-nav bar-train" id="register12306Page-header"> <a class="icon icon-left-nav pull-left" data-rel="back" href="/"></a> <h1 class="title">注册12306账号</h1> </header> '), 
        $out += ' <div class="page-content" id="register12306Page-content">  <div class="registerStep"> <div class="registerStep-img"> <div class="registerStep-info registerStep-info_1">信息填写</div> <div class="registerStep-info registerStep-info_2">手机验证</div> <div class="registerStep-info registerStep-info_3">注册成功</div> </div> </div>   <div class="loginInfo"> <div class="loginInfo-item loginInfo-item_userName"> <label class="loginInfo-label">用户名</label> <input class="loginInfo-input" type="text" maxlength="20" placeholder="6-20位字母、数字或“_”,字母开头"/> </div> <div class="loginInfo-item loginInfo-item_password"> <label class="loginInfo-label">登录密码</label> <input class="loginInfo-input" type="password" maxlength="20" placeholder="6-20位字母、数字或“_”"/> </div> </div>   <div class="userInfo"> <div class="userInfo-item userInfo-item_name"> <label class="userInfo-label">姓名</label> <input class="userInfo-input" type="text" maxlength="10" placeholder="请输入姓名"/> </div> <div class="userInfo-item userInfo-item_card"> <label class="userInfo-label">身份证</label> <input class="userInfo-input" type="text" maxlength="18" placeholder="请输入18位身份证号码"/> </div> <div class="userInfo-item userInfo-item_phone"> <label class="userInfo-label">手机号码</label> <input class="userInfo-input" type="text" maxlength="11" placeholder="请输入11位手机号码"/> </div> </div>  <button class="btn btn-block btn-primary nextButton">下一步</button> </div>  </div> ', 
        new String($out);
    }), /*v:1*/
    template("registcode", function($data) {
        "use strict";
        var $utils = this, isShowHeader = ($utils.$helpers, $data.isShowHeader), $escape = $utils.$escape, successTips = $data.successTips, mobileNo = $data.mobileNo, $out = "";
        return $out += '<div class="page">  ', isShowHeader && ($out += ' <header class="bar bar-nav bar-train" id="check12306Page-header"> <a class="icon icon-left-nav pull-left" data-rel="back" href="/"></a> <h1 class="title">注册12306账号</h1> </header> '), 
        $out += ' <div class="page-content" id="check12306Page-content">  <div class="registerStep"> <div class="registerStep-img"> <div class="registerStep-info registerStep-info_1">信息填写</div> <div class="registerStep-info registerStep-info_2">手机验证</div> <div class="registerStep-info registerStep-info_3">注册成功</div> </div> </div>   <div class="registerInfo"> ', 
        $out += $escape(successTips), $out += ' </div>   <div class="userInfo"> <div class="userInfo-item userInfo-item_phone"> <label class="userInfo-label">手机号</label> <span class="userInfo-text">', 
        $out += $escape(mobileNo), $out += '</span> <div class="userInfo-sms">发短信</div> </div> <div class="userInfo-item userInfo-item_code"> <label class="userInfo-label">验证码</label> <input class="userInfo-input" type="text" maxlength="10" placeholder="请输入手机验证码"/> </div> </div>  <button class="btn btn-block btn-primary nextButton">免费注册</button> </div>  </div> ', 
        new String($out);
    }), /*v:1*/
    template("registsuccess", function($data) {
        "use strict";
        var $utils = this, isShowHeader = ($utils.$helpers, $data.isShowHeader), $out = "";
        return $out += '<div class="page">  ', isShowHeader && ($out += ' <header class="bar bar-nav bar-train" id="success12306Page-header"> <a class="icon icon-left-nav pull-left" data-rel="back" href="/"></a> <h1 class="title">注册12306账号</h1> </header> '), 
        $out += ' <div class="page-content" id="success12306Page-content">  <div class="registerStep"> <div class="registerStep-img"> <div class="registerStep-info registerStep-info_1">信息填写</div> <div class="registerStep-info registerStep-info_2">手机验证</div> <div class="registerStep-info registerStep-info_3">注册成功</div> </div> </div>   <div class="registerInfo1"> 恭喜您, 注册成功 </div>   <div class="registerInfo2"> 现在可以使用12306账号,进行预定了 </div>  </div>  </div> ', 
        new String($out);
    });
}();