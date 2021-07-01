var __yyyy, __mm, __dd, __dateOfWeek, __ymd , __ymd1 ;
var gs_parm  = new Array() ; 
 __CallGetDate();
 __CallGetfirsDate();
function __CallGetDate() {
	
	var today = new Date();
	__yyyy = (today.getYear()).toString();
	__mm = (today.getMonth()+1).toString();
	__dd = (today.getDate()).toString();
	__dateOfWeek = today.getDay();

	switch ( __yyyy.length ) { 
		case 1 : __yyyy="000"+__yyyy; break; 
		case 2 : __yyyy="00"+__yyyy; break; 
		case 3 : __yyyy="0"+__yyyy; break; 
		case 4 : break; 
		default : __yyyy="9999";
	}

	//alert(__mm.length);
	if ( __mm.length == 1 ) { __mm="0"+__mm; }
	if ( __dd.length == 1 ) { __dd="0"+__dd; }
	__dateOfWeek = __getDayStr(__dateOfWeek);
//alert("1");
	__ymd=__yyyy+__mm+__dd;
	return __ymd ;
}
function __CallGetfirsDate() {
	
	var today = new Date();
	__yyyy = (today.getYear()).toString();
	__mm = (today.getMonth()+1).toString();
	__dd = (today.getDate()).toString();
	__dateOfWeek = today.getDay();

	switch ( __yyyy.length ) { 
		case 1 : __yyyy="000"+__yyyy; break; 
		case 2 : __yyyy="00"+__yyyy; break; 
		case 3 : __yyyy="0"+__yyyy; break; 
		case 4 : break; 
		default : __yyyy="9999";
	}

	//alert(__mm.length);
	if ( __mm.length == 1 ) { __mm="0"+__mm; }
	if ( __dd.length == 1 ) { __dd="0"+__dd; }
	__dd = "01" ; 
	__dateOfWeek = __getDayStr(__dateOfWeek);
//alert("1");
	__ymd1=__yyyy+__mm+__dd;
	return __ymd1 ;
}
function __getDayStr(day) { // 요일문자 호출
	if ( day<0 || day>6 ) { return null; }
	var x = new Array("일", "월", "화", "수","목", "금", "토");
	return(x[day]);
}

 function PopupOpenDialog(myW,myH){ 
	// alert("111");
	if( PopWinValue=null ){ try{PopWinValue.close(); PopWinValue=null;}catch(e){} }

	var w = window.top.screen.width;
	var h = window.top.screen.height;
	var Lf=0, Tp=150;
			
	if(w>=myW){Lf=(w-myW)/2;}
	if(h>=myH){Tp=(h-myH)/2;}

	PopWinValue = window.showModalDialog(strURL,"" ,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
	//PopWinValue.focus();
}

function GetParam(){
	//alert("aa" + location.search);
	if(location.search){ //주소중 파라메터 부분이 있으면,
	   	
	   var str0=location.search.split("&")[0]; //첫번째 파라메터를 str0에 담고
	   var str1=location.search.split("&")[1]; //첫번째 파라메터를 str0에 담고
	   var str2=location.search.split("&")[2]; //첫번째 파라메터를 str0에 담고
	   //var str3=location.search.split("&")[3]; //첫번째 파라메터를 str0에 담고
	  
	   gs_parm[0]=str0.split("=")[1]; //첫번째 파라메터의 값
	   if(str1 != undefined){
	   gs_parm[1]=str1.split("=")[1]; }  //첫번째 파라메터의 값
	   gs_parm[2]=str2;

		//gs_parm[2]=str2.split("=")[1]; //첫번째 파라메터의 값
		//gs_parm[3]=str2.split("=")[1]; //첫번째 파라메터의 값
	    //alert(gs_car_seq_no) ;
	   
	   //alert("str0::"+str0); alert("str1::"+str1); alert("str2::"+str2);
	   //alert("gs_parm[0]::"+gs_parm[0]); alert("gs_parm[1]::"+gs_parm[1]); alert("gs_parm[2]::"+gs_parm[2]);
	   
  } 

}


/******************************************************************************
	Description :  Trim 
******************************************************************************/ 

function strim(str){
  var leftI = 0;
  var rightI = 0;
  
  for(i = 0; i<str.length ;i++){
   if(str.substring(i,i+1)==' '){
    leftI++;
   }else{
    break;
   }
  }
  str = str.substring(leftI,str.length);
  for(j=str.length; j>0;j--){
   if(str.substring(j-1,j)==' '){
    rightI++;
   }else{
    break;
   }
  }
  
  str = str.substring(0,str.length - rightI);
  return str;
 }


 function OnStatusStart(){ 
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible"; 
 }
 function TheStatusEnd(row){
	window.status="조회가 완료 되었습니다.";
	//ft_cnt.innerText = "조회건수 : " + row + " 건";
	 //document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
 }

 function TheStatusEnd1(){
	window.status="조회가 완료 되었습니다.";
	//ft_cnt.innerText = "조회건수 : " + row + " 건";
	// document.all.LowerFrame.style.visibility="hidden";
 }
/******************************************************************************
	Description : EXCEL 출력 Dialog 
******************************************************************************/  
 function ExcelDialog(obj,name){ 
	obj.SaveExcel("Yes Dialog", false/*Suppress*/, false/*Reserved*/,true/*Show Save Dialog*/, name + ".xls"/*Path*/); 
}

	// 파일 확장자
	function gn_FileType(filename){
		var file_length = filename.length;
		var gsgbn = false;
		var rtnfile = "";
		var file_exp = "";
		for (var k=0; k <= file_length; k++) {
			if (filename.charAt(k) == ".") {
				file_exp = filename.substring(k+1,file_length).toLowerCase();
			}
		}

		return file_exp;
	}

	//문자값에 콤마를 찍는다.
	function gn_setint(src){ 
		
		var len	= 0;
		var comma = 0;
		var buf  = "";
		var dest = "";
		
		buf = "" + src + "";
		len = buf.length;
		
		for(i = 3; i < len; i+=3) {
			if((i < len) || (len < (i+4)))	comma++;
		}
		
		for(i = 0; i < len; i++) {
			if(i == (len - (3 * comma))) {
				dest += ",";
				dest += buf.charAt(i);
				comma--;
			}
			else {
				dest += buf.charAt(i);
			}
		}

		if (dest.substring(0,1)=="-") {
			if (dest.substring(1,2)==",") {
				dest = dest.substring(0,1) + dest.substring(2,dest.length);
			}
		}

		return dest;
	}