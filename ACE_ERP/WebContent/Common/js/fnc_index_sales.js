/*var operation = null
var districtLeft = 214, dongLeft = 34, classLeft = 220, subClassLeft = 408, shopLeft = 365
var districtTop = 68, dongTop = 150, classTop = 150, subClassTop = 150, shopTop = 173
var itemCount = 0, districtID = -1
var mode = "", oldTitle = "", searchCondition = "";*/

//[�Լ�]		1�ڸ� ���ڸ� 02�� ���� 2�ڸ� ���ڿ���..
function makeDigit(num)	
{
	if(num.length < 2){
		num='0'+num;}
	return num;
}
//[�Լ�]		���ڼ��� ��빮�� üũ
function CHECK(form) {
	if(form.value.length < 4 || form.value.length > 8) {
	 return false;
	}
	for(var i=0; i<form.value.length; i++) {
	 var chr=form.value.substr(i,1);
	 if((chr<'0' || chr >'9') && (chr < 'a' || chr >'z') && (chr < 'A' || chr >'Z') ) {
	   return false;
	   }
	}
	return true;
}

//[�Լ�]		����üũ
function ISNUMBER(form)
{
	for(var i=0; i<form.value.length; i++)
	{
		var chr=form.value.substr(i,1);
		if(chr<'0' || chr >'9')
		  return false;
	 }
	 return true;
}
//[�Լ�]		�빮�� �����
function toUpper(form)	
{
	form.value = form.value.toUpperCase();
}

//[�Լ�]		��Ű ����			setCookie("blnEvent","true","July 18, 2010 00:00:00")
function setCookie(name, value) {
	document.cookie = name + "=" + escape( value ) + ";" ; 
} 

//[�Լ�]		��Ű �����
function clearCookie(name) {
    var today = new Date()
    //���� ��¥�� ��Ű �Ҹ� ��¥�� �����Ѵ�.
    var expire_date = new Date(today.getTime() - 60*60*24*1000)
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString()
}
//[�Լ�]		��Ű �б�
function getCookie(name) {
   var from_idx = document.cookie.indexOf(name+'=');
   if (from_idx != -1) { 
      from_idx += name.length + 1;
      to_idx = document.cookie.indexOf(';', from_idx) ;
      if (to_idx == -1) {
            to_idx = document.cookie.length;
      }
      return unescape(document.cookie.substring(from_idx, to_idx))
   }
}


/*function changeDate()		//������� �����ϸ� ��û����ȣ�� �ҷ��´�.
{
	targetURL = "select.asp?oper=date&id=" + document.searchForm.sYear[document.searchForm.sYear.selectedIndex].value;
	targetURL = targetURL	+ makeDigit(document.searchForm.sMonth[document.searchForm.sMonth.selectedIndex].value);
	targetURL = targetURL	+ makeDigit(document.searchForm.sDay[document.searchForm.sDay.selectedIndex].value);
	top.execute1.location = targetURL;
}*/

//[����]		��û����ȣ�� �Է��ϸ� �ش� ��ȣ�� ���ϴ� �ݾױ���, ��û�����ڵ�, �����ǸŰ��� �ҷ��´�.
function changeJpno(form)
{
	if (form.value.length < 12) {
		alert("��û����ȣ�� 12�ڸ��Դϴ�. 12�ڸ��� ��� �Է����ּ���");
		form.focus();
		return; 
	}
	if (!ISNUMBER(form)) {	 //�̺κ��� DOM ���̶� �迭�� ()��.. ó��..
		alert("��û����ȣ�� ��� �����Դϴ�. ���ڷ� �Է��� �ּ���...");
		form.focus();
		return;
	}

	targetURL1 = "select.asp?oper=wgu&id=" + document.searchForm.KG56JPNO.value;
	top.execute1.location = targetURL1;		//�ݾױ���
	targetURL2 = "select.asp?oper=vcls&id=" + document.searchForm.KG56JPNO.value;
	top.execute2.location = targetURL2;		//��û�����ڵ�
	targetURL3 = "select.asp?oper=clas&id=" + document.searchForm.KG56JPNO.value;
	top.execute3.location = targetURL3;		//Ȯ�������ڵ�
	targetURL4 = "select.asp?oper=panw&id=" + document.searchForm.KG56JPNO.value;
	top.execute4.location = targetURL4;		//�����ǸŰ�
	fn_sel(form.value);
}

//[���� ����]	���� ������
function qUpdate()
{
	document.searchForm.action="qUpdate.asp";	//?targetPrice="+document.all.targetPrice.value;
	document.searchForm.submit();
}

//[�� ����]	�׸��� �׸���
function drawGrid()
{
	showNews();
	document.searchForm.action="drawGrid.asp";
	document.searchForm.submit();
//	top.execute1.location = "drawGrid.asp";
}


//[����]		show progressbar
function showNews()
{
var win = document.all.newsWin;
	win.src = "";
	win.style.display = "none";
	win.src = "../library/progress.htm";
	win.style.display = "";
}
//[����]		hide progressbar 
function hideNews()
{
	var win = document.all.newsWin;
	win.style.display = "none";
	win.src = "";
}


//[����]		���̾� ����ϸ� ����� �͸� �����ֱ�
function toggleLayer(layerIDX)
{
//	alert(layerIDX);
//	alert(window.idTabDiv[layerIDX]);
	var layerCnt = window.arrayLayer.length;	
	for(i=0 ; i<layerCnt ; i++) {	//��� ���̾ �ݾƹ�����
		window.idTabDiv[i].className="TabUnselected";
		window.arrayLayer[i].style.display = "none" ;
	}
	//�ش� ���̾ ����
	window.idTabDiv[layerIDX].className="TabSelected";
	window.arrayLayer[layerIDX].style.display = "";
//	if(layerIDX=1)
//			initGrid();		//1�����̾��̸� �׸����ʱ�ȭ����
}


//[����]		���̾� ����ϸ� ����� �͸� �����ֱ�
function togLeftMenu()
{
	var leftMenuCookie = getCookie("togLeftMenu");
	if (leftMenuCookie == 'close') 	{
		setCookie("togLeftMenu","open");
		window.leftMenuArrow.src="http://localhost:8080/erp/images/Common/arrow_menuClose.gif";
		window.leftMenuLayer.style.display = "" ;
	}else{
		setCookie("togLeftMenu","close");
		window.leftMenuArrow.src="http://localhost:8080/erp/images/Common/arrow_menuOpen.gif";
		window.leftMenuLayer.style.display = "none" ;
	}
}




//[����]		������ �ʱ�ȭ
function init() {
//	setCookie("togLeftMenu","close",1);
	document.searchForm.KG56JPNO.focus();
}
