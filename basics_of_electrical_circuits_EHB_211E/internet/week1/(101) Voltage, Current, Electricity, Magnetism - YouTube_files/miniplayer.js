(function(g){var window=this;var O5=function(a,b){var c="ytp-miniplayer-button-bottom-right",d={G:"svg",U:{height:"18px",version:"1.1",viewBox:"0 0 22 18",width:"22px"},S:[{G:"g",U:{fill:"none","fill-rule":"evenodd",stroke:"none","stroke-width":"1"},S:[{G:"g",U:{transform:"translate(-1.000000, -3.000000)"},S:[{G:"polygon",U:{points:"0 0 24 0 24 24 0 24"}},{G:"path",U:{d:"M19,7 L5,7 L5,17 L19,17 L19,7 Z M23,19 L23,4.98 C23,3.88 22.1,3 21,3 L3,3 C1.9,3 1,3.88 1,4.98 L1,19 C1,20.1 1.9,21 3,21 L21,21 C22.1,21 23,20.1 23,19 Z M21,19.02 L3,19.02 L3,4.97 L21,4.97 L21,19.02 Z",
fill:"#fff","fill-rule":"nonzero"}}]}]}]},e="Video sayfas\u0131n\u0131 a\u00e7";a.T().ca("kevlar_miniplayer_expand_top")&&(c="ytp-miniplayer-button-top-left",d={G:"svg",U:{height:"24px",version:"1.1",viewBox:"0 0 24 24",width:"24px"},S:[{G:"g",U:{fill:"none","fill-rule":"evenodd",stroke:"none","stroke-width":"1"},S:[{G:"g",U:{transform:"translate(12.000000, 12.000000) scale(-1, 1) translate(-12.000000, -12.000000) "},S:[{G:"path",U:{d:"M19,19 L5,19 L5,5 L12,5 L12,3 L5,3 C3.89,3 3,3.9 3,5 L3,19 C3,20.1 3.89,21 5,21 L19,21 C20.1,21 21,20.1 21,19 L21,12 L19,12 L19,19 Z M14,3 L14,5 L17.59,5 L7.76,14.83 L9.17,16.24 L19,6.41 L19,10 L21,10 L21,3 L14,3 Z",
fill:"#fff","fill-rule":"nonzero"}}]}]}]},e="Geni\u015flet");g.V.call(this,{G:"button",ia:["ytp-miniplayer-expand-watch-page-button","ytp-button",c],U:{title:"{{title}}","data-tooltip-target-id":"ytp-miniplayer-expand-watch-page-button"},S:[d]});this.J=a;this.ra("click",this.onClick,this);this.ua("title",g.CX(a,e,"i"));g.dg(this,g.aY(b.Gb(),this.element))},P5=function(a){g.V.call(this,{G:"div",
L:"ytp-miniplayer-ui"});this.Vg=!1;this.player=a;this.R(a,"minimized",this.lj);this.R(a,"onStateChange",this.yQ)},Q5=function(a){g.vS.call(this,a);
this.u=new P5(this.player);this.u.hide();g.$O(this.player,this.u.element,4);a.app.visibility.u&&(this.load(),g.J(a.getRootNode(),"ytp-player-minimized",!0))};
g.u(O5,g.V);O5.prototype.onClick=function(){this.J.va("onExpandMiniplayer")};g.u(P5,g.V);g.k=P5.prototype;
g.k.show=function(){this.qd=new g.qn(this.wp,null,this);this.qd.start();if(!this.Vg){this.tooltip=new g.p_(this.player,this);g.C(this,this.tooltip);g.$O(this.player,this.tooltip.element,4);this.tooltip.scale=.6;this.Ib=new g.VX(this.player);g.C(this,this.Ib);this.xk=new g.V({G:"div",L:"ytp-miniplayer-scrim"});g.C(this,this.xk);this.xk.da(this.element);this.R(this.xk.element,"click",this.tE);var a=new g.V({G:"button",ia:["ytp-miniplayer-close-button","ytp-button"],U:{"aria-label":"Kapat"},S:[g.WM()]});
g.C(this,a);a.da(this.xk.element);this.R(a.element,"click",this.fn);a=new O5(this.player,this);g.C(this,a);a.da(this.xk.element);this.Tk=new g.V({G:"div",L:"ytp-miniplayer-controls"});g.C(this,this.Tk);this.Tk.da(this.xk.element);this.R(this.Tk.element,"click",this.tE);var b=new g.V({G:"div",L:"ytp-miniplayer-button-container"});g.C(this,b);b.da(this.Tk.element);a=new g.V({G:"div",L:"ytp-miniplayer-play-button-container"});g.C(this,a);a.da(this.Tk.element);var c=new g.V({G:"div",L:"ytp-miniplayer-button-container"});
g.C(this,c);c.da(this.Tk.element);this.QE=new g.qZ(this.player,this,!1);g.C(this,this.QE);this.QE.da(b.element);b=new g.nZ(this.player,this);g.C(this,b);b.da(a.element);this.nextButton=new g.qZ(this.player,this,!0);g.C(this,this.nextButton);this.nextButton.da(c.element);this.uh=new g.e_(this.player,this);g.C(this,this.uh);this.uh.da(this.xk.element);this.Lc=new g.uZ(this.player,this);g.C(this,this.Lc);g.$O(this.player,this.Lc.element,4);this.Gs=new g.V({G:"div",L:"ytp-miniplayer-buttons"});g.C(this,
this.Gs);g.$O(this.player,this.Gs.element,4);a=new g.V({G:"button",ia:["ytp-miniplayer-close-button","ytp-button"],U:{"aria-label":"Kapat"},S:[g.WM()]});g.C(this,a);a.da(this.Gs.element);this.R(a.element,"click",this.fn);a=new g.V({G:"button",ia:["ytp-miniplayer-replay-button","ytp-button"],U:{"aria-label":"Kapat"},S:[g.iN()]});g.C(this,a);a.da(this.Gs.element);this.R(a.element,"click",this.EO);this.R(this.player,"presentingplayerstatechange",this.Tb);this.R(this.player,"appresize",this.Qa);this.R(this.player,
"fullscreentoggled",this.Qa);this.Qa();this.Vg=!0}0!==this.player.getPlayerState()&&g.V.prototype.show.call(this);this.Lc.show();this.player.unloadModule("annotations_module")};
g.k.hide=function(){this.qd&&(this.qd.dispose(),this.qd=void 0);g.V.prototype.hide.call(this);this.player.app.visibility.u||(this.Vg&&this.Lc.hide(),this.player.loadModule("annotations_module"))};
g.k.aa=function(){this.qd&&(this.qd.dispose(),this.qd=void 0);g.V.prototype.aa.call(this)};
g.k.fn=function(){this.player.stopVideo();this.player.va("onCloseMiniplayer")};
g.k.EO=function(){this.player.playVideo()};
g.k.tE=function(a){if(a.target===this.xk.element||a.target===this.Tk.element)g.R(this.player.T().experiments,"kevlar_miniplayer_play_pause_on_scrim")?g.RK(g.fI(this.player))?this.player.pauseVideo():this.player.playVideo():this.player.va("onExpandMiniplayer")};
g.k.lj=function(){g.J(this.player.getRootNode(),"ytp-player-minimized",this.player.app.visibility.u)};
g.k.Jd=function(){this.Lc.Ec();this.uh.Ec()};
g.k.wp=function(){this.Jd();this.qd&&this.qd.start()};
g.k.Tb=function(a){g.T(a.state,32)&&this.tooltip.hide()};
g.k.Qa=function(){this.Lc.setPosition(0,g.yG(this.player).getPlayerSize().width,!1);g.wZ(this.Lc)};
g.k.yQ=function(a){this.player.app.visibility.u&&(0===a?this.hide():this.show())};
g.k.Gb=function(){return this.tooltip};
g.k.zd=function(){return!1};
g.k.Sf=function(){return!1};
g.k.Xg=function(){return!1};
g.k.ly=function(){};
g.k.Vk=function(){};
g.k.oo=function(){};
g.k.il=function(){return null};
g.k.Nh=function(){return new g.ig(0,0,0,0)};
g.k.handleGlobalKeyDown=function(){return!1};
g.k.handleGlobalKeyUp=function(){return!1};
g.k.mn=function(a,b,c,d,e){var f=0,h=d=0,l=g.Eg(a);if(b){c=g.zn(b,"ytp-prev-button")||g.zn(b,"ytp-next-button");var m=g.zn(b,"ytp-play-button"),n=g.zn(b,"ytp-miniplayer-expand-watch-page-button");c?f=h=12:m?(b=g.Cg(b,this.element),h=b.x,f=b.y-12):n&&(h=g.zn(b,"ytp-miniplayer-button-top-left"),f=g.Cg(b,this.element),b=g.Eg(b),h?(h=8,f=f.y+40):(h=f.x-l.width+b.width,f=f.y-20))}else h=c-l.width/2,d=25+(e||0);b=g.yG(this.player).getPlayerSize().width;e=f+(e||0);l=g.be(h,0,b-l.width);e?(a.style.top=e+
"px",a.style.bottom=""):(a.style.top="",a.style.bottom=d+"px");a.style.left=l+"px"};
g.k.showControls=function(){};
g.k.uj=function(){};
g.k.Ni=function(){return!1};g.u(Q5,g.vS);Q5.prototype.create=function(){};
Q5.prototype.ph=function(){return!1};
Q5.prototype.load=function(){this.player.hideControls();this.u.show()};
Q5.prototype.unload=function(){this.player.showControls();this.u.hide()};g.oX.miniplayer=Q5;})(_yt_player);
