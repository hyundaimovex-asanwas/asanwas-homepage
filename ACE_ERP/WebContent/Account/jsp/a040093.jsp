<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	분양 데이터 수신 
+ 프로그램 ID:  a040093.jsp 
+ 기 능 정 의	: 분양데이터수신
+ 최 초 이 력	: 정영식
+ 변 경 이 력	: 정영식 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정   자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
//get_cookdata();
//lfn_init();
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_gubun=""; //chk 시 click구분
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
     fnInit_tree(tree_idx);	//트리초기화 호출
   // gcem_appdt.text=gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
   
     gclx_ingb_0.bindcolval ="0";
     gclx_seqno_0.bindcolval="0";
     gclx_regsts_0.bindcolval="0";

}

/******************************************************************************
	Description : 조회
	Parameter  :  
******************************************************************************/
function ln_Query(){
	
  		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040093_s1?v_str1="+gclx_ingb_0.bindcolval
                                                                             +"&v_str2="+gclx_seqno_0.bindcolval
                                                                             +"&v_str3="+gclx_regsts_0.bindcolval;
	    gcds_data.Reset(); 
	
	
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Chk(){


}


/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_Close() {
  
}


/******************************************************************************
	Description : 반영
	Parameter  : 
******************************************************************************/
function ln_Save() {
 
   //필수 항목 체크 
    if(!ln_Chk_Save())return;

	if (gcds_data.IsUpdated) {
		if (confirm("분양데이터를 수신 하시겠습니까?")){	
			gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040093_t1?";
			gctr_data2.Parameters = "v_str1="+gs_userid;
		
			//prompt('',gcds_data.text);
			gctr_data2.post();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
	//상태값이 대기일 경우만 생성 가능 
	//사업자번호 및 주민번호 체크해야할까????
******************************************************************************/
function ln_Chk_Save() {

  //상태값이 대기 일경우만 가능 

   for(i=1;i<=gcds_data.countrow;i++){
	   
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
			
			if(gcds_data.namevalue(i,"BS_VENDID") == ""){//사업자번호
				alert(i+" 행의 사업자번호가  존재하지 않습니다. 확인 바랍니다.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_VENDNM") == ""){//사업체명
				alert(i+" 행의 사업체명을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_DAT") == ""){//일자
				alert(i+" 행의 일자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_CND") == ""){//업태
				alert(i+" 행의 일자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_KND") == ""){//업종
				alert(i+" 행의 일자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_EMPNM") == ""){//담당자
				alert(i+" 행의 담당자를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BS_EMAIL") == ""){//담당자 이메일
				alert(i+" 행의 담당자 이메일을 입력하세요.");
				return false;
			}
			
		}
   }
   
   return true;
   
   	
					
}
/******************************************************************************
	Description : 인사 데이터 태그 초기화 
******************************************************************************/
function ln_Clear(){
		
}

/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_Create() { 
 
  
}




/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}



/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Popup(gbn){

 
}

/******************************************************************************
Description : 공백에  . 넣기
******************************************************************************/
function ln_blank_insert(k){

	if(gcds_data.namevalue(k,"BS_ADDR2") == ""){//
	   gcds_data.namevalue(k,"BS_ADDR2")=".";
	}
	
	if(gcds_data.namevalue(k,"BS_TELNO") == ""){//
	   gcds_data.namevalue(k,"BS_TELNO")=".";
	}

}



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue"   VALUE="a040093_t1(I:USER=gcds_data)">
</object>




</comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
	
	if((row==0) && (colid=="CHK")){
		
	    if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;
	  
         for(i=1;i<=gcds_data.countrow;i++){
            if(gs_gubun=="1"||gs_gubun==""){
	        	if(gcds_data.namevalue(i,"BS_STS")=="N"){
		        	gcds_data.namevalue(i,"CHK")="T";	
		        	ln_blank_insert(i);
	        	}
            }else{
            	if(gcds_data.namevalue(i,"BS_STS")=="N"){
		        	gcds_data.namevalue(i,"CHK")="F";	   
		        	gcds_data.undo(i);  
	        	}
            }	
		}
    }else if((row!=0) && (colid=="CHK")){
        if(gcds_data.namevalue(row,"BS_STS")=="N"){
		    if(gcds_data.namevalue(row,"CHK")=="T"){
		    	ln_blank_insert(row);
		 	}else{
		 	        gcds_data.undo(row);
		 	}
		 }else{
		 	gcds_data.undo(row);
		 }
    }   
        
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data2" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040093_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
        <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_banyoung.gif"		    style="cursor:hand" onclick="ln_Save()">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		        style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  
  <tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="100px;" bgcolor="#eeeeee" align="center">입금구분</td>
			<td width="190px" class="tab18" align="left"><comment id="__NSID__">
			<object id=gclx_ingb_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^계약금,2^중도금1차 ,3^중도금2차 ,4^중도금3차 ,5^중도금4차 ,6^잔금">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">회수</td>
			<td width="190px" class="tab24" align="left" ><comment id="__NSID__">
				<object id=gclx_seqno_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^1회,2^2회,3^3회,4^4회,5^5회">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">등록구분</td>
			<td class="tab14"  align="left">
			<comment id="__NSID__">
			<object id=gclx_regsts_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-35px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			         value="0^전체,1^미등록,2^등록">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			             value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
			
		</tr>
	</table>

	<tr>
  
  
	<tr>
	<td COLSPAN=2>
	<!--Grid-->
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
			<tr>
				<td><b><font size="2" color="blue"> * 분양데이터수신  </font> </b></td>
				<td align=right>
					
		  		<td>
			</tr>
			
			<tr> 			
				<td ALIGN=LEFT VALIGN=TOP colspan=2>
					<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01 style="WIDTH:874px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
          				<PARAM NAME="DataID"			VALUE="gcds_data">
          				<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="Fillarea"	    	VALUE=true>
						<param name="ColSizing"        value="true">
						<param name=MultiRowSelect	value=true>
						<param name=UsingOneClick  value="1">
						<param name="editable"          value="TRUE">
						<param name="indwidth"          value="0">
						<PARAM NAME="Format"			VALUE="  	
						    <C>ID=CHK 	                 Name='선택'               width=28   HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<G>  Name='분양정보',                                                     HeadBgColor=#B9D4DC,  align=center, 
							<C>ID=BS_DNO,	         Name=동,		            width=35,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true  </C>
							<C>ID=BS_HNO,	         Name=호,		            width=35,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true </C>
							<C>ID=BS_VENDID,	     Name=사업자번호,		    width=90,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,	edit=none  sort = true  </C>
							<C>ID=BS_VENDNM,	     Name=사업체명,	        width=90,  HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,		edit=none  sort = true  </C>
							<C>ID=BS_INGB,	         Name=입금,	            width=50,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true   EditStyle=Combo	Data='1:계약금,2:중도금1차,3:중도금2차,4:중도금3차,5:중도금4차,6:잔금'</C>
							<C>ID=BS_SEQNO,	         Name=회수,	            width=40,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true   EditStyle=Combo	Data='1:1회,2:2회,3:3회,4:4회,5:5회'</C>
							<C>ID=BS_DAT,	         Name=일자,                 width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center,  edit=none, sort=true   MASK ='XXXX/XX/XX'</C>						
							<C>ID=BS_AMT,	         Name=공급가,              width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=right,     edit=none, sort=true </C>
							<C>ID=BS_TAXAMT,         Name=부가세,             width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=right,     edit=none, sort=true </C>
							<C>ID=BS_TOTAMT,         Name=합계,                 width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=right,     edit=none, sort=true </C>
							
							<C>ID=BS_PDTNM,        Name=품명,	             width=90,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>
							<C>ID=BS_TAXKND,       Name=종류,	             width=40,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center, edit=none, sort=true EditStyle=Combo	Data='1:과세,3:면세'</C>
							<C>ID=BS_CND,            Name=업태,	                 width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>
							<C>ID=BS_KND,             Name=업종,	             width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>
							<C>ID=BS_COMYN,        Name=업체구분,           width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>
							<C>ID=BS_EMPNM,       Name=담당자,	             width=70,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=center, edit=none, sort=true </C>
							<C>ID=BS_EMAIL,          Name=이메일,	             width=100,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>
							<C>ID=BS_HPNO,          Name=핸드폰,	             width=100,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>			
							<C>ID=BS_STS,             Name=상태,	             width=40,	HeadBgColor=#B9D4DC, BgColor={IF(BS_STS='N','#FFCC66','FFFFFF')} , align=left,       edit=none, sort=true </C>			
							</G>
							">
            		  </object>
            		  </comment><script>__ws__(__NSID__);</script>
			  	</td>
			  </tr>
			</table>
 		</td>  
 	</tr>
  	<tr>
		<td colspan="2" height="30" align="left">조회건수 : <label id="lbl_search"></label></td>
  	</tr>	
			</table>
 	</td>
 	</tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>



