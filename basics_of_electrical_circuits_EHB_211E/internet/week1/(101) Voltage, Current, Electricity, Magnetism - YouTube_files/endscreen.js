(function(g){var window=this;var HEa=function(a,b){a.va("onAutonavCoundownStarted",b)},O4=function(a,b,c){var d=b.Ja();
g.J(a.element,"ytp-suggestion-set",!!d.videoId);var e=b.getPlaylistId();c=b.yd(c?c:"mqdefault.jpg");var f=b instanceof g.PE&&b.lengthSeconds?g.vO(b.lengthSeconds):null,h=!!e;e=h&&"RD"===(new g.TF(e.substr(0,2),e.substr(2))).type;var l=b instanceof g.PE?b.isLivePlayback:null;d={title:b.title,author:b.author,author_and_views:d.shortViewCount?b.author+" \u2022 "+d.shortViewCount:b.author,aria_label:b.Un||g.ZI("\u0130zle: $TITLE",{TITLE:b.title}),duration:f,url:b.Rj(),is_live:l,is_list:h,is_mix:e,background:c?
"background-image: url("+c+")":"",views_and_publish_time:d.shortViewCount?d.shortViewCount+" \u2022 "+d.publishedTimeText:d.publishedTimeText};b instanceof g.UF&&(d.playlist_length=b.getLength());a.update(d)},P4=function(a){var b=a.T();
g.V.call(this,{G:"a",U:{href:"{{url}}",target:b.B?b.F:"","aria-label":"{{aria_label}}","data-is-live":"{{is_live}}","data-is-list":"{{is_list}}","data-is-mix":"{{is_mix}}"},S:[{G:"div",L:"ytp-autonav-endscreen-upnext-thumbnail",U:{style:"{{background}}"},S:[{G:"div",ia:["ytp-autonav-duration-card"],Z:"{{duration}}"}]},{G:"div",ia:["ytp-autonav-endscreen-upnext-title","ytp-autonav-title-card"],Z:"{{title}}"},{G:"div",ia:["ytp-autonav-endscreen-upnext-author","ytp-autonav-author-card"],Z:"{{author}}"},
{G:"div",ia:["ytp-autonav-endscreen-upnext-author","ytp-autonav-view-and-date-card"],Z:"{{views_and_publish_time}}"}]});this.J=a;this.suggestion=null},R4=function(a,b){b=void 0===b?!1:b;
g.V.call(this,{G:"div"});var c=this;this.I=b;this.D=0;var d=a.T(),e=d.B;this.J=a;g.dX(this.J,this.element,this,18788);this.suggestion=null;this.u=new g.V({G:"a",U:{href:"{{url}}",target:e?d.F:"","aria-label":"{{aria_label}}","data-is-live":"{{is_live}}","data-is-list":"{{is_list}}","data-is-mix":"{{is_mix}}"},S:[{G:"div",L:"ytp-autonav-endscreen-upnext-header",Z:"{{upNextHeader}}"},{G:"div",L:"ytp-autonav-endscreen-upnext-thumbnail",U:{style:"{{background}}"}},{G:"div",L:"ytp-autonav-endscreen-upnext-title",
Z:"{{title}}"},{G:"div",L:"ytp-autonav-endscreen-upnext-author",Z:"{{author}}"}]});g.C(this,this.u);this.u.da(this.element);this.B=new g.V({G:"div"});g.C(this,this.B);this.B.da(this.element);this.cancelButton=new g.V({G:"span",ia:["ytp-autonav-endscreen-upnext-button","ytp-autonav-endscreen-upnext-cancel-button"],U:{"aria-label":"Otomatik oynatmay\u0131 iptal et"},Z:"\u0130ptal"});g.C(this,this.cancelButton);this.cancelButton.da(this.B.element);this.cancelButton.ra("click",this.jK,this);this.playButton=
new g.V({G:"a",ia:["ytp-autonav-endscreen-upnext-button","ytp-autonav-endscreen-upnext-play-button"],U:{href:"{{url}}","aria-label":"Sonraki videoyu oynat"},Z:"\u015eimdi Oynat"});g.C(this,this.playButton);this.playButton.da(this.B.element);this.playButton.ra("click",this.kK,this);this.F=new g.H(function(){Q4(c)},500);
g.C(this,this.F);this.RC();this.R(a,"autonavvisibility",this.RC)},Q4=function(a){var b=S4(a),c=Math.min(a.D?Date.now()-a.D:0,b);
a.u.ua("upNextHeader",g.ZI("S\u0131radaki video $SECONDS i\u00e7inde oynat\u0131lacak",{SECONDS:String(Math.ceil((b-c)/1E3))}));0>=b-c?a.select(!0):a.Zj()&&a.F.start()},S4=function(a){return g.Q(a.J.T().experiments,"autoplay_time")||1E4},T4=function(a,b){g.V.call(this,{G:"div",
ia:["html5-endscreen","ytp-player-content",b||"base-endscreen"]});this.created=!1;this.player=a},V4=function(a){g.V.call(this,{G:"div",
ia:["ytp-upnext","ytp-player-content"],U:{"aria-label":"{{aria_label}}"},S:[{G:"div",L:"ytp-cued-thumbnail-overlay-image",U:{style:"{{background}}"}},{G:"span",L:"ytp-upnext-top",S:[{G:"span",L:"ytp-upnext-header",Z:"S\u0131radaki"},{G:"span",L:"ytp-upnext-title",Z:"{{title}}"},{G:"span",L:"ytp-upnext-author",Z:"{{author}}"}]},{G:"a",L:"ytp-upnext-autoplay-icon",U:{role:"button",href:"{{url}}","aria-label":"Sonraki videoyu oynat"},S:[{G:"svg",U:{height:"100%",version:"1.1",viewBox:"0 0 72 72",width:"100%"},
S:[{G:"circle",L:"ytp-svg-autoplay-circle",U:{cx:"36",cy:"36",fill:"#fff","fill-opacity":"0.3",r:"31.5"}},{G:"circle",L:"ytp-svg-autoplay-ring",U:{cx:"-36",cy:"36","fill-opacity":"0",r:"33.5",stroke:"#FFFFFF","stroke-dasharray":"211","stroke-dashoffset":"-211","stroke-width":"4",transform:"rotate(-90)"}},{G:"path",L:"ytp-svg-fill",U:{d:"M 24,48 41,36 24,24 V 48 z M 44,24 v 24 h 4 V 24 h -4 z"}}]}]},{G:"span",L:"ytp-upnext-bottom",S:[{G:"span",L:"ytp-upnext-cancel"},{G:"span",L:"ytp-upnext-paused",
Z:"Otomatik oynatma duraklat\u0131ld\u0131"}]}]});this.api=a;this.cancelButton=null;this.F=this.ga("ytp-svg-autoplay-ring");this.C=this.notification=this.u=this.suggestion=null;this.D=new g.H(this.Vq,5E3,this);this.B=0;var b=this.ga("ytp-upnext-cancel");this.cancelButton=new g.V({G:"button",ia:["ytp-upnext-cancel-button","ytp-button"],U:{tabindex:"0","aria-label":"Otomatik oynatmay\u0131 iptal et"},Z:"\u0130ptal"});g.C(this,this.cancelButton);this.cancelButton.ra("click",this.rL,this);this.cancelButton.da(b);
g.C(this,this.D);g.dX(this.api,this.element,this,18788);b=this.ga("ytp-upnext-autoplay-icon");this.R(b,"click",this.sL);this.gD();this.R(a,"autonavvisibility",this.gD);this.R(a,"mdxnowautoplaying",this.EN);this.R(a,"mdxautoplaycanceled",this.FN);this.R(a,"mdxautoplayupnext",this.mG);U4(this)&&(a=(a=g.PW(g.LW(this.api)))?a.xI():null)&&this.mG(a);g.J(this.element,"ytp-upnext-mobile",this.api.T().u)},U4=function(a){return 3===a.api.getPresentingPlayerType()},W4=function(a,b){var c=b||g.Q(a.api.T().experiments,
"autoplay_time")||1E4,d=Math.min(IEa(a),c);
c=Math.min(d/c,1);a.F.setAttribute("stroke-dashoffset",""+-211*(c+1));1<=c&&!U4(a)?a.select(!0):a.Zj()&&a.u.start()},IEa=function(a){return(0,g.O)()-a.B},X4=function(a){T4.call(this,a,"autonav-endscreen");
this.videoData=this.suggestions=null;this.table=new g.V({G:"div",S:[{G:"div",L:"ytp-autonav-endscreen-upnext-header",Z:"Daha fazla video"}]});this.K=new g.V({G:"div",L:"ytp-suggestions-container"});this.videos=[];this.C=null;this.F=this.I=!1;this.B=new R4(this.player);g.C(this,this.B);this.B.da(this.element);a.T().ca("web_new_autonav_countdown")?this.u=this.B:(this.u=new V4(a),g.$O(this.player,this.u.element,4),g.C(this,this.u));this.D=new g.sR(this);g.C(this,this.D);g.C(this,this.table);this.table.da(this.element);
this.table.show();g.C(this,this.K);this.K.da(this.table.element);this.hide()},JEa=function(a,b){return g.Pc(b.suggestions,function(c){c=g.oZ(a.player.T(),c);
g.C(a,c);return c})},Y4=function(a){var b=a.an();
b!==a.F&&(a.F=b,a.player.V("autonavvisibility"),a.F?(a.B!==a.u&&a.B.hide(),a.table.hide()):(a.B!==a.u&&a.B.show(),a.table.show()))},KEa=function(a){T4.call(this,a,"subscribecard-endscreen");
var b=a.getVideoData();this.u=new g.V({G:"div",L:"ytp-subscribe-card",S:[{G:"img",L:"ytp-author-image",U:{src:b.Pe}},{G:"div",L:"ytp-subscribe-card-right",S:[{G:"div",L:"ytp-author-name",Z:b.author},{G:"div",L:"html5-subscribe-button-container"}]}]});g.C(this,this.u);this.u.da(this.element);this.subscribeButton=new g.eY("Abone Ol",null,"Abonelikten \u00e7\u0131k",null,!0,!1,b.Cg,b.subscribed,"trailer-endscreen",null,null,a);g.C(this,this.subscribeButton);this.subscribeButton.da(this.u.ga("html5-subscribe-button-container"));
this.hide()},Z4=function(a){var b=a.T(),c=g.ZA||g.rg?{style:"will-change: opacity"}:void 0,d=b.B,e=["ytp-videowall-still"];
b.u&&e.push("ytp-videowall-show-text");g.V.call(this,{G:"a",ia:e,U:{href:"{{url}}",target:d?b.F:"","aria-label":"{{aria_label}}","data-is-live":"{{is_live}}","data-is-list":"{{is_list}}","data-is-mix":"{{is_mix}}"},S:[{G:"div",L:"ytp-videowall-still-image",U:{style:"{{background}}"}},{G:"span",L:"ytp-videowall-still-info",S:[{G:"span",L:"ytp-videowall-still-info-bg",S:[{G:"span",L:"ytp-videowall-still-info-content",U:c,S:[{G:"span",L:"ytp-videowall-still-info-title",Z:"{{title}}"},{G:"span",L:"ytp-videowall-still-info-author",
Z:"{{author_and_views}}"},{G:"span",L:"ytp-videowall-still-info-live",Z:"Canl\u0131"},{G:"span",L:"ytp-videowall-still-info-duration",Z:"{{duration}}"}]}]}]},{G:"span",ia:["ytp-videowall-still-listlabel-regular","ytp-videowall-still-listlabel"],S:[{G:"span",L:"ytp-videowall-still-listlabel-icon"},"Oynatma Listesi",{G:"span",L:"ytp-videowall-still-listlabel-length",S:[" (",{G:"span",Z:"{{playlist_length}}"},")"]}]},{G:"span",ia:["ytp-videowall-still-listlabel-mix","ytp-videowall-still-listlabel"],
S:[{G:"span",L:"ytp-videowall-still-listlabel-mix-icon"},"Mix",{G:"span",L:"ytp-videowall-still-listlabel-length",Z:" (50+)"}]}]});this.suggestion=null;this.B=d;this.api=a;this.u=new g.sR(this);g.C(this,this.u);this.ra("click",this.onClick);this.ra("keypress",this.C);this.u.R(a,"videodatachange",this.Oa);g.GM(a,this.element,this);this.Oa()},$4=function(a){T4.call(this,a,"videowall-endscreen");
var b=this;this.J=a;this.C=0;this.stills=[];this.D=this.videoData=this.suggestions=null;this.F=this.P=!1;this.K=null;this.B=new g.sR(this);g.C(this,this.B);this.I=new g.H(function(){g.I(b.element,"ytp-show-tiles")},0);
g.C(this,this.I);var c=new g.V({G:"button",ia:["ytp-button","ytp-endscreen-previous"],U:{"aria-label":"\u00d6nceki"},S:[g.RM()]});g.C(this,c);c.da(this.element);c.ra("click",this.pK,this);this.table=new g.zM({G:"div",L:"ytp-endscreen-content"});g.C(this,this.table);this.table.da(this.element);c=new g.V({G:"button",ia:["ytp-button","ytp-endscreen-next"],U:{"aria-label":"Sonraki"},S:[g.SM()]});g.C(this,c);c.da(this.element);c.ra("click",this.oK,this);a.T().ca("web_new_autonav_countdown")?this.u=new R4(a,
!0):this.u=new V4(a);g.C(this,this.u);g.$O(this.player,this.u.element,4);this.hide()},a5=function(a){return g.cX(a.player)&&a.Xn()&&!a.D},LEa=function(a,b){return g.Pc(b.suggestions,function(c){c=g.oZ(a.J.T(),c);
g.C(a,c);return c})},b5=function(a){var b=a.an();
b!==a.P&&(a.P=b,a.player.V("autonavvisibility"))},c5=function(a){g.vS.call(this,a);
this.endScreen=null;this.listeners=new g.sR(this);g.C(this,this.listeners);this.u=a.T();MEa(a)?this.u.ca("web_new_big_thumbnail_endscreen")?this.endScreen=new X4(a):this.endScreen=new $4(this.player):this.u.Kc?this.endScreen=new KEa(this.player):this.endScreen=new T4(this.player);g.C(this,this.endScreen);g.$O(this.player,this.endScreen.element,4);this.vF();this.listeners.R(a,"videodatachange",this.vF,this);this.listeners.R(a,g.rD("endscreen"),this.lK,this);this.listeners.R(a,g.sD("endscreen"),this.mK,
this)},MEa=function(a){a=a.T();
return a.jb&&!a.Kc};
g.u(P4,g.V);P4.prototype.ud=function(a,b,c){c&&g.F(this.element,{marginLeft:Math.floor(14*a)+"px"});c=this.element.children[0];g.F(c,{width:Math.floor(220*a)+"px",height:Math.floor(118*b)+"px"});(c=c.children[0])&&g.F(c,{margin:Math.floor(4*b)+"px "+Math.floor(4*a)+"px"});for(c=0;c<Math.min(this.element.children.length,NEa.length);++c)g.F(this.element.children[c],{marginTop:Math.floor(NEa[c]*b)+"px",width:Math.floor(220*a)+"px"})};
var NEa=[20,13,11,8];g.u(R4,g.V);g.k=R4.prototype;
g.k.ep=function(a){this.suggestion!==a&&(this.suggestion=a,O4(this.u,a),this.suggestion.Pt?(this.C||(this.C=new g.V({G:"div",S:[{G:"svg",U:{fill:"none",height:"16",width:"74"},S:[{G:"path",U:{d:"M22.26 8.83V12h-1.49V3.47h3.27c.95 0 1.7.25 2.26.74.57.5.85 1.16.85 1.97 0 .84-.28 1.49-.83 1.95-.55.47-1.31.7-2.3.7h-1.76zm0-1.19h1.78c.52 0 .93-.12 1.2-.37.28-.25.42-.6.42-1.08 0-.46-.14-.82-.42-1.1a1.62 1.62 0 00-1.16-.43h-1.82v2.98zm9.37-.68a3.52 3.52 0 00-.58-.05c-.65 0-1.1.25-1.32.75V12h-1.42V5.66h1.36l.03.7a1.6 1.6 0 011.43-.82c.2 0 .37.03.5.08v1.34zm3.57 5.16c-.9 0-1.63-.29-2.2-.85a3.1 3.1 0 01-.83-2.28v-.17c0-.63.12-1.2.36-1.7a2.72 2.72 0 012.5-1.58c.87 0 1.54.28 2 .83.48.55.72 1.33.72 2.34v.57H33.6c.05.52.22.94.53 1.24.3.3.7.46 1.16.46.65 0 1.18-.26 1.59-.79l.77.73c-.26.38-.6.68-1.02.89-.42.2-.9.3-1.43.3zm-.17-5.43c-.39 0-.7.13-.94.4-.24.28-.4.66-.46 1.15h2.71v-.1a1.72 1.72 0 00-.38-1.09 1.18 1.18 0 00-.93-.36zm5.17-1.03l.04.66a2.28 2.28 0 011.83-.78c.84 0 1.42.33 1.74.98.46-.65 1.1-.98 1.94-.98.7 0 1.22.2 1.56.58.34.39.52.96.53 1.71V12H46.4V7.87c0-.4-.08-.7-.26-.88-.18-.19-.47-.28-.87-.28-.33 0-.6.09-.8.26-.2.17-.35.4-.43.68V12h-1.42V7.83c-.02-.75-.4-1.12-1.14-1.12-.57 0-.97.23-1.21.7V12h-1.43V5.66h1.35zM50.8 12H49.4V5.66h1.42V12zm-1.5-7.99c0-.22.06-.4.2-.54.14-.15.34-.22.6-.22.25 0 .45.07.6.22.13.14.2.32.2.54 0 .22-.07.4-.2.54-.15.14-.35.21-.6.21-.26 0-.46-.07-.6-.2a.75.75 0 01-.2-.55zm6.9 7.37a2.2 2.2 0 01-1.78.74c-.69 0-1.21-.2-1.57-.6-.35-.4-.52-1-.52-1.75V5.66h1.42v4.09c0 .8.34 1.2 1 1.2.7 0 1.16-.24 1.4-.74V5.66h1.43V12h-1.34l-.04-.62zm4.17-5.72l.04.66a2.28 2.28 0 011.83-.78c.84 0 1.42.33 1.74.98.46-.65 1.1-.98 1.94-.98.7 0 1.22.2 1.56.58.34.39.52.96.53 1.71V12h-1.43V7.87c0-.4-.08-.7-.26-.88-.18-.19-.47-.28-.87-.28-.33 0-.6.09-.8.26-.2.17-.35.4-.43.68V12h-1.42V7.83c-.02-.75-.4-1.12-1.14-1.12-.57 0-.97.23-1.21.7V12h-1.43V5.66h1.35z",fill:"#aaa"}},
{G:"rect",U:{fill:"#d00",height:"13.96",rx:"1",width:"13.96",x:"1.96",y:"1"}},{G:"path",U:{"clip-rule":"evenodd",d:"M7.7 12.5v-3h1.53c1.01 0 1.8-.24 2.37-.72.57-.48.86-1.14.86-1.97 0-.55-.13-1.04-.4-1.47a2.58 2.58 0 00-1.11-1 3.84 3.84 0 00-1.69-.35H5.94v8.5H7.7zm1.56-4.42H7.7V5.4h1.6c.44 0 .78.14 1.02.4.25.25.37.59.37 1 0 .41-.12.72-.37.94-.24.22-.6.33-1.06.33z",fill:"#fff","fill-rule":"evenodd"}}]}]}),this.C.da(this.u.element,2),g.C(this,this.C)),this.C.show()):this.C&&this.C.hide())};
g.k.ud=function(a,b){if(!a||!b){var c=this.J.Nh(!0,this.J.isFullscreen());a=c.width/1024;b=c.height/576}var d=(c=g.MW(this.J))?"auto":"0";g.F(this.element,{marginTop:Math.floor(47*b)+"px",width:Math.floor(360*a)+"px",marginLeft:""+d,marginRight:""+d});g.Dg(this.u.element.children[1],Math.floor(360*a),Math.floor(202*b));d=Math.floor(175*a);var e=Math.floor(36*b);g.Dg(this.cancelButton.element,d,e);g.Dg(this.playButton.element,d,e);d={marginTop:Math.floor(20*b)+"px"};for(e=1;e<this.u.element.childElementCount;e++)g.F(this.u.element.children[e],
d);g.F(this.B.element,d);this.C&&g.F(this.u.element.children[3],{marginTop:Math.floor(12*b)+"px"});c?(g.I(this.element,"ytp-player-content"),g.I(this.element,"ytp-upnext"),this.u.ua("upNextHeader",g.ZI("S\u0131radaki video $SECONDS i\u00e7inde oynat\u0131lacak",{SECONDS:String(Math.ceil(S4(this)/1E3))})),this.B.show()):(g.Bn(this.element,"ytp-player-content"),g.Bn(this.element,"ytp-upnext"),this.u.ua("upNextHeader","S\u0131radaki"),this.B.hide())};
g.k.Zj=function(){return 0<this.D};
g.k.yn=function(){this.Zj()||(this.D=Date.now(),Q4(this),HEa(this.J,S4(this)))};
g.k.Jl=function(){this.tj();Q4(this)};
g.k.tj=function(){this.Zj()&&(this.F.stop(),this.D=0)};
g.k.select=function(a){this.J.nextVideo(!1,void 0===a?!1:a);this.tj()};
g.k.kK=function(a){g.yX(a,this.J)&&this.select()};
g.k.jK=function(){g.OW(this.J,!0)};
g.k.RC=function(){var a=g.MW(this.J);this.I&&this.Wa!==a&&g.CM(this,a);this.ud();g.KM(this.J,this.element,a)};g.u(T4,g.V);g.k=T4.prototype;g.k.create=function(){this.created=!0};
g.k.destroy=function(){this.created=!1};
g.k.Xn=function(){return!1};
g.k.an=function(){return!1};
g.k.hC=function(){return!1};g.u(V4,g.V);g.k=V4.prototype;g.k.Vq=function(){this.notification&&(this.D.stop(),this.Bb(this.C),this.C=null,this.notification.close(),this.notification=null)};
g.k.ep=function(a){this.suggestion=a;O4(this,a,"hqdefault.jpg")};
g.k.gD=function(){g.CM(this,g.MW(this.api));g.KM(this.api,this.element,g.MW(this.api))};
g.k.XN=function(){window.focus();this.Vq()};
g.k.yn=function(a){var b=this;this.Zj()||(g.Po("a11y-announce","S\u0131radaki "+this.suggestion.title),this.B=(0,g.O)(),this.u=new g.H(function(){W4(b,a)},25),W4(this,a),HEa(this.api,a||g.Q(this.api.T().experiments,"autoplay_time")||1E4));
g.Bn(this.element,"ytp-upnext-autoplay-paused")};
g.k.hide=function(){g.V.prototype.hide.call(this)};
g.k.Zj=function(){return!!this.u};
g.k.Jl=function(){this.tj();this.B=(0,g.O)();W4(this);g.I(this.element,"ytp-upnext-autoplay-paused")};
g.k.tj=function(){this.Zj()&&(this.u.dispose(),this.u=null)};
g.k.select=function(a){a=void 0===a?!1:a;if(g.R(this.api.T().experiments,"autonav_notifications")&&a&&window.Notification&&document.hasFocus){var b=Notification.permission;"default"===b?Notification.requestPermission():"granted"!==b||document.hasFocus()||(b=this.suggestion.Ja(),this.Vq(),this.notification=new Notification("S\u0131radaki",{body:b.title,icon:b.yd()}),this.C=this.R(this.notification,"click",this.XN),this.D.start())}this.tj();this.api.nextVideo(!1,a)};
g.k.sL=function(a){!g.Me(this.cancelButton.element,g.ep(a))&&g.yX(a,this.api)&&this.select()};
g.k.rL=function(){g.OW(this.api,!0)};
g.k.EN=function(a){U4(this);this.show();this.yn(a)};
g.k.mG=function(a){U4(this);this.suggestion&&this.suggestion.Ja().videoId===a.Ja().videoId||this.ep(a)};
g.k.FN=function(){U4(this);this.tj();this.hide()};
g.k.aa=function(){this.tj();this.Vq();g.V.prototype.aa.call(this)};g.u(X4,T4);g.k=X4.prototype;g.k.create=function(){T4.prototype.create.call(this);this.D.R(this.player,"appresize",this.ud);this.D.R(this.player,"onVideoAreaChange",this.ud);this.D.R(this.player,"videodatachange",this.Oa);this.D.R(this.player,"autonavchange",this.QC);this.D.R(this.player,"autonavcancel",this.iK);this.Oa()};
g.k.show=function(){T4.prototype.show.call(this);(this.I||this.C&&this.C!==this.videoData.clientPlaybackNonce)&&g.OW(this.player,!1);g.cX(this.player)&&this.Xn()&&!this.C?(Y4(this),2===this.videoData.autonavState?this.player.T().ca("fast_autonav_in_background")&&3===this.player.getVisibilityState()?this.u.select(!0):this.u.yn():3===this.videoData.autonavState&&this.u.Jl()):(g.OW(this.player,!0),Y4(this));this.ud()};
g.k.hide=function(){T4.prototype.hide.call(this);this.u.Jl();Y4(this)};
g.k.ud=function(){var a=this.player.Nh(!0,this.player.isFullscreen()),b=a.width/1024;a=a.height/576;Y4(this);this.B.ud(b,a);g.F(this.element,{padding:"0 "+Math.floor(75*b)+"px"});if(!this.F){g.F(this.table.element,{marginTop:Math.floor(47*a)+"px",width:Math.floor(454*b)+"px"});for(var c=g.q(this.videos.entries()),d=c.next();!d.done;d=c.next()){d=g.q(d.value);var e=d.next().value;d.next().value.ud(b,a,1===e%2)}}};
g.k.Oa=function(){var a=this.player.getVideoData();if(this.videoData!==a&&a){this.videoData=a;if((this.suggestions=JEa(this,a))&&this.suggestions.length)for(this.u.ep(this.suggestions[0]),this.u!==this.B&&this.B.ep(this.suggestions[0]),a=0;a<OEa.length;++a){var b=OEa[a];if(this.suggestions&&this.suggestions[b]){this.videos[a]=new P4(this.player);var c=this.videos[a];b=this.suggestions[b];c.suggestion!==b&&(c.suggestion=b,O4(c,b));g.C(this,this.videos[a]);this.videos[a].da(this.K.element)}}this.ud()}};
g.k.QC=function(a){1===a?(this.I=!1,this.C=this.videoData.clientPlaybackNonce,this.u.tj(),this.Wa&&this.ud()):(this.I=!0,this.an()&&(2===a?this.u.yn():3===a&&this.u.Jl()))};
g.k.iK=function(a){a?this.QC(1):(this.C=null,this.I=!1)};
g.k.Xn=function(){return 1!==this.videoData.autonavState};
g.k.an=function(){return this.Wa&&g.cX(this.player)&&this.Xn()&&!this.C};
var OEa=[1,3,2,4];g.u(KEa,T4);g.u(Z4,g.V);Z4.prototype.select=function(){var a=this.suggestion.Ja().videoId,b=this.suggestion.getPlaylistId();(g.N0(this.api.app,a,this.suggestion.hd,b,void 0,this.suggestion.RA||void 0)||this.api.ca("web_player_endscreen_double_log_fix_killswitch"))&&g.eX(this.api,this.element)};
Z4.prototype.onClick=function(a){g.yX(a,this.api,this.B,this.suggestion.hd||void 0)&&this.select()};
Z4.prototype.C=function(a){switch(a.keyCode){case 13:case 32:g.jp(a)||(this.select(),g.ip(a))}};
Z4.prototype.Oa=function(){var a=this.api.getVideoData(),b=this.api.T();this.B=a.Hc?!1:b.B};g.u($4,T4);g.k=$4.prototype;g.k.create=function(){T4.prototype.create.call(this);var a=this.player.getVideoData();a&&(this.suggestions=LEa(this,a),this.videoData=a);this.ud();this.B.R(this.player,"appresize",this.ud);this.B.R(this.player,"onVideoAreaChange",this.ud);this.B.R(this.player,"videodatachange",this.Oa);this.B.R(this.player,"autonavchange",this.ax);this.B.R(this.player,"autonavcancel",this.nK);a=this.videoData.autonavState;a!==this.K&&this.ax(a);this.B.R(this.element,"transitionend",this.lP)};
g.k.destroy=function(){g.Rr(this.B);g.fg(this.stills);this.stills=[];this.suggestions=null;T4.prototype.destroy.call(this);g.Bn(this.element,"ytp-show-tiles");this.I.stop();this.K=this.videoData.autonavState};
g.k.Xn=function(){return 1!==this.videoData.autonavState};
g.k.show=function(){T4.prototype.show.call(this);g.Bn(this.element,"ytp-show-tiles");this.player.T().u?g.tn(this.I):this.I.start();(this.F||this.D&&this.D!==this.videoData.clientPlaybackNonce)&&g.OW(this.player,!1);a5(this)?(b5(this),2===this.videoData.autonavState?this.player.T().ca("fast_autonav_in_background")&&3===this.player.getVisibilityState()?this.u.select(!0):this.u.yn():3===this.videoData.autonavState&&this.u.Jl()):(g.OW(this.player,!0),b5(this))};
g.k.hide=function(){T4.prototype.hide.call(this);this.u.Jl();b5(this)};
g.k.lP=function(a){g.ep(a)===this.element&&this.ud()};
g.k.ud=function(){if(this.suggestions&&this.suggestions.length){g.I(this.element,"ytp-endscreen-paginate");var a=this.J.Nh(!0,this.J.isFullscreen()),b=g.HW(this.J);b&&(b=b.zd()?48:32,a.width-=2*b);var c=a.width/a.height,d=96/54,e=b=2,f=Math.max(a.width/96,2),h=Math.max(a.height/54,2),l=this.suggestions.length,m=Math.pow(2,2);var n=l*m+(Math.pow(2,2)-m);n+=Math.pow(2,2)-m;for(n-=m;0<n&&(b<f||e<h);){var p=b/2,r=e/2,t=b<=f-2&&n>=r*m,w=e<=h-2&&n>=p*m;if((p+1)/r*d/c>c/(p/(r+1)*d)&&w)n-=p*m,e+=2;else if(t)n-=
r*m,b+=2;else if(w)n-=p*m,e+=2;else break}d=!1;n>=3*m&&6>=l*m-n&&(4<=e||4<=b)&&(d=!0);m=96*b;n=54*e;c=m/n<c?a.height/n:a.width/m;c=Math.min(c,2);m=Math.floor(Math.min(a.width,m*c));n=Math.floor(Math.min(a.height,n*c));a=this.table.element;g.Dg(a,m,n);g.F(a,{marginLeft:m/-2+"px",marginTop:n/-2+"px"});this.u.ep(this.suggestions[0]);this.u instanceof R4&&this.u.ud();g.J(this.element,"ytp-endscreen-takeover",a5(this));b5(this);m+=4;n+=4;for(f=c=0;f<b;f++)for(h=0;h<e;h++)if(p=c,r=0,d&&f>=b-2&&h>=e-2?r=
1:0===h%2&&0===f%2&&(2>h&&2>f?0===h&&0===f&&(r=2):r=2),p=g.ce(p+this.C,l),0!==r){t=this.stills[c];t||(t=new Z4(this.player),this.stills[c]=t,a.appendChild(t.element));w=Math.floor(n*h/e);var x=Math.floor(m*f/b),y=Math.floor(n*(h+r)/e)-w-4,D=Math.floor(m*(f+r)/b)-x-4;g.wg(t.element,x,w);g.Dg(t.element,D,y);g.F(t.element,"transitionDelay",(h+f)/20+"s");g.J(t.element,"ytp-videowall-still-mini",1===r);g.J(t.element,"ytp-videowall-still-large",2<r);r=t;p=this.suggestions[p];r.suggestion!==p&&(r.suggestion=
p,t=r.api.T(),w=g.zn(r.element,"ytp-videowall-still-large")?"hqdefault.jpg":"mqdefault.jpg",O4(r,p,w),g.GB(t)&&(t=p.Rj(),t=g.Ld(t,g.KT({},"emb_rel_end")),r.ua("url",t)),(p=(p=p.hd)&&p.itct)&&g.HM(r.api,r.element,p));c++}g.J(this.element,"ytp-endscreen-paginate",c<l);for(b=this.stills.length-1;b>=c;b--)e=this.stills[b],g.Je(e.element),g.eg(e);this.stills.length=c}};
g.k.Oa=function(){var a=this.player.getVideoData();this.videoData!==a&&(this.C=0,this.suggestions=LEa(this,a),this.videoData=a,this.ud())};
g.k.oK=function(){this.C+=this.stills.length;this.ud()};
g.k.pK=function(){this.C-=this.stills.length;this.ud()};
g.k.hC=function(){return this.u.Zj()};
g.k.ax=function(a){1===a?(this.F=!1,this.D=this.videoData.clientPlaybackNonce,this.u.tj(),this.Wa&&this.ud()):(this.F=!0,this.Wa&&a5(this)&&(2===a?this.u.yn():3===a&&this.u.Jl()))};
g.k.nK=function(a){if(a){for(a=0;a<this.stills.length;a++)g.KM(this.J,this.stills[a].element,!0);this.ax(1)}else this.D=null,this.F=!1;this.ud()};
g.k.an=function(){return this.Wa&&a5(this)};g.u(c5,g.vS);g.k=c5.prototype;g.k.HC=function(){var a=this.player.getVideoData(),b=!!(a&&a.suggestions&&a.suggestions.length);b=!MEa(this.player)||b;var c=a.dm||g.PB(a.Na),d=g.O0(this.player.app);a=a.mutedAutoplay;return b&&!c&&!d&&!a};
g.k.GC=function(){return this.endScreen.an()};
g.k.mJ=function(){return this.GC()?this.endScreen.hC():!1};
g.k.aa=function(){g.aX(this.player,"endscreen");g.vS.prototype.aa.call(this)};
g.k.load=function(){g.vS.prototype.load.call(this);this.endScreen.show()};
g.k.unload=function(){g.vS.prototype.unload.call(this);this.endScreen.hide();this.endScreen.destroy()};
g.k.lK=function(a){this.HC()&&(this.endScreen.created||this.endScreen.create(),"load"===a.getId()&&this.load())};
g.k.mK=function(a){"load"===a.getId()&&this.loaded&&this.unload()};
g.k.vF=function(){g.aX(this.player,"endscreen");var a=this.player.getVideoData();a=new g.oD(Math.max(1E3*(a.lengthSeconds-10),0),0x8000000000000,{id:"preload",namespace:"endscreen"});var b=new g.oD(0x8000000000000,0x8000000000000,{id:"load",priority:6,namespace:"endscreen"});g.kM(this.player,[a,b])};g.oX.endscreen=c5;})(_yt_player);
