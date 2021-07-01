function namosw_init_slide_layers()
{
  var layer;
  var i;
  var args = namosw_init_slide_layers.arguments;

  for (i = 0; i < args.length; i += 2) {
      if (navigator.appName == 'Netscape') {
   layer = document.layers[args[i]];
        if (args[i+1] == 1)
          layer.left = -layer.clip.width  + 5;
        else if (args[i+1] == 2)
          layer.top  = -layer.clip.height + 5;
   layer._sl_dir    = (layer.top < 0) ? 'v' : ((layer.left < 0) ? 'h' : '');
        if (layer._sl_dir == '') return;
   layer._sl_maxpos = 0
   layer._sl_minpos = (layer.top < 0) ? layer.top : layer.left;
        if (layer.document.namoswmenucontainer)
          layer = layer.document.namoswmenucontainer;
   if (layer.captureEvents)
     layer.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT);
      } else {
   layer = document.all[args[i]];
        if (args[i+1] == 1)
          layer.style.pixelLeft = -layer.style.pixelWidth  + 5;
        else if (args[i+1] == 2)
          layer.style.pixelTop  = -layer.style.pixelHeight + 5;
   layer._sl_dir    = (layer.style.pixelTop < 0) ? 'v' : ((layer.style.pixelLeft < 0) ? 'h' : '');
        if (layer._sl_dir == '') return;
   layer._sl_maxpos = 0;
   layer._sl_minpos = (layer.style.pixelTop < 0) ? layer.style.pixelTop : layer.style.pixelLeft;
      }
      layer.onmouseover  = namosw_sl_mouseover;
      layer.onmouseout   = namosw_sl_mouseout;
  }
}

function namosw_sl_mouseover()
{
  var layer = this;
  var name  = (navigator.appName == 'Netscape') ? layer.name : layer.id;
  if (name == 'namoswmenucontainer') {
    if (navigator.appName == 'Netscape') {      // redundant check
      layer = layer.parentLayer;
      name  = layer.name;
    }
  }
  if (layer._down_interval)
    clearInterval(layer._down_interval)
  layer._up_interval = setInterval("namosw_sl_mouseover2('" + name + "')", 50)
}

function namosw_sl_mouseout()
{
  var layer = this;
  var name  = (navigator.appName == 'Netscape') ? layer.name : layer.id;
  if (name == 'namoswmenucontainer') {
    if (navigator.appName == 'Netscape') {      // redundant check
      layer = layer.parentLayer;
      name  = layer.name;
    }
  }
  if (layer._up_interval)
    clearInterval(layer._up_interval)
  layer._down_interval = setInterval("namosw_sl_mouseout2('" + name + "')", 50)
}

function namosw_sl_mouseover2(name)
{
  var layer;
  if (navigator.appName == 'Netscape') {
    layer = document.layers[name];
    if (layer._sl_dir == 'h' && layer.left < layer._sl_maxpos)
      layer.left += 5;
    else if (layer._sl_dir == 'v' && layer.top < layer._sl_maxpos)
      layer.top += 5;
    else if (layer._up_interval)
      clearInterval(layer._up_interval);
  } else {
    layer = document.all[name];
    if (layer._sl_dir == 'h' && layer.style.pixelLeft < layer._sl_maxpos)
      layer.style.pixelLeft += 5
    else if (layer._sl_dir == 'v' && layer.style.pixelTop < layer._sl_maxpos)
      layer.style.pixelTop += 5;
    else if (layer._up_interval)
      clearInterval(layer._up_interval);
  }
}

function namosw_sl_mouseout2(name)
{
  var layer;
  if (navigator.appName == 'Netscape') {
    layer = document.layers[name];
    if (layer._sl_dir == 'h' && layer._sl_minpos < layer.left)
      layer.left -= 5;
    else if (layer._sl_dir == 'v' && layer._sl_minpos < layer.top)
      layer.top  -= 5;
    else if (layer._down_interval)
      clearInterval(layer._down_interval);
  } else {
    layer = document.all[name];
    if (layer._sl_dir == 'h' && layer._sl_minpos < layer.style.pixelLeft)
      layer.style.pixelLeft -= 5;
    else if (layer._sl_dir == 'v' && layer._sl_minpos < layer.style.pixelTop)
      layer.style.pixelTop -= 5;
    else if (layer._down_interval)
      clearInterval(layer._down_interval);
  }
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}