
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 다른시스템과 Interface 팝업
+ 프로그램 ID	:  Commiface.html
+ 기 능 정 의	:  타시스템과의 Interface
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.12.14
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>Data Interface</title>

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
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
get_cookdata();
var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;
	gs_strGubun = strParam[0];
	//txt_atkornam.value=strParam[1];
	
  //gcem_fsdat_fr.text=gcurdate.substring(0,4) + gcurdate.substring(5,7)+'01';
	gcem_fsdat_fr.text='20050601';
	gcem_fsdat_to.text=gs_date;
	gcra_sign.CodeValue="N";

  //지점구분
    gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();
	//업무구분
	gcds_comcode01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=1155";
	//prompt("",gcds_comcode01.DataID);
	gcds_comcode01.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  //MST
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commiface_s1?v_str1="+gclx_fdcode.Bindcolval+"&v_str2="+gcra_sign.codevalue
	                                                    +"&v_str3="+gclx_fsdat.Bindcolval+"&v_str4="+gcem_fsdat_fr.text
																											+"&v_str5="+gcem_fsdat_to.text;   
	//prompt("gcds_data01",gcds_data01.DataID);
	gcds_data01.Reset();

  //DTL
  gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commiface_s2?v_str1="+gclx_fdcode.Bindcolval
	                                                    +"&v_str3="+gclx_fsdat.Bindcolval+"&v_str4="+gcem_fsdat_fr.text
																											+"&v_str5="+gcem_fsdat_to.text;   
	//prompt("gcds_data02",gcds_data02.DataID);
	gcds_data03.Reset();
}


/******************************************************************************
	Description : 저장 후 재 조회
******************************************************************************/
function ln_Query_After(){

	//Bredge Mst
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commiface_s1?v_str1="+gclx_fdcode.Bindcolval+"&v_str2="+gcra_sign.codevalue
	                                                    +"&v_str3="+gclx_fsdat.Bindcolval+"&v_str4="+gcem_fsdat_fr.text
																											+"&v_str5="+gcem_fsdat_to.text;   
	//prompt("gcds_data01",gcds_data01.DataID);
	gcds_data01.Reset();

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장 (Data 전송)
******************************************************************************/
function ln_Save(){
  
	if (gcds_data01.IsUpdated ){
		if (confirm("전송하시겠습니까?")){	
			gctr_data01.Action ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commiface_t1?";
			//gctr_data01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;					
			gctr_data01.post();
     // prompt("", gcds_data01.text);
			//prompt("", gcds_data03.text);
			ln_Query_After();
		}	
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

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
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
/*	if (p=="A") {
		var row = gcds_data01.rowposition;
		window.returnValue = gcds_data01.namevalue(row,"ATCODE") + ";" 
	                   	 + gcds_data01.namevalue(row,"ATKORNAM")+ ";" 
											 + gcds_data01.namevalue(row,"ATDECR");
		window.close();
	} else {
		window.close();
	}
	*/
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Bredge MST table -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표 MST table -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Bredge DTL table -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표 table -->
<comment id="__NSID__"><object  id=gcds_data02classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점구분 -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 업무구분 -->
<comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="commiface_t1(I:USER=gcds_data01,I:USER2=gcds_data03)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">
	gcds_comcode01.insertrow(1);
	gcds_comcode01.namevalue(1,"ATCODE") = "";
	gcds_comcode01.namevalue(1,"ATKORNAM") = "전체";
	gcds_comcode01.index=0;
</script>
-->
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else{
		if (gcra_sign.CodeValue=="Y"){
			gcgd_disp01.Editable =false;
		}else{
			gcgd_disp01.Editable =true;
		}
	}

</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
   for(i=1;i<=row;i++){
		gcds_data03.UserStatus(i)=1
	 }
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
  gs_save_gubun="";
  
	if((row==0) && (gcgd_disp01.GetColumn()=="CHK")){

		if(gcds_data01.namevalue(1,"CHK")=="T"){
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="T";
			}
		}
	}
</script>

<script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">
		gcds_comcode01.deleterow(1);
		gclx_fsdat.index = 0;
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020001_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_b_trans.gif"	  style="cursor:hand" onClick="ln_Save()" >
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;처리기간&nbsp;</nobr></td>
		<td class="tab18" style="width:150px;"><nobr>&nbsp;
			<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="YYYY/MM/DD">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
			 </object></comment><script>__ws__(__NSID__);</script> 
				~&nbsp;
			 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="YYYY/MM/DD">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr> 
		</td>

		<td width="70px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전송유무&nbsp;</nobr></td>
		<td class="tab18" style="width:100px;"><nobr>&nbsp;
			<comment id="__NSID__"><object  id=gcra_sign classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
			style="position:relative;left:0px;top:0px;height:20;width:140px;cursor:hand;">
				<param name=Cols     value="3">
				<param name=Format   value="Y^완료,N^대기">
			</object></comment><script>__ws__(__NSID__);</script> 	</nobr>
		</td> 

		<td width="70px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;지점구분</nobr></td>
		<td class="tab18" style="width:150px;" align=center><nobr>&nbsp;
			<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				style="position:relative;left:-25px;top:2px;font-size:12px;width:80px;">
					<param name=ComboDataID    value="gcds_comfield">
					<param name=CBDataColumns	 value="FDCODE,FDNAME">
					<param name=SearchColumn	 value=FDNAME>
					<param name=Sort			     value=false>
					<param name=ListExprFormat value="FDNAME">								
					<param name=BindColumn		 value="FDCODE">
			</object></comment><script>__ws__(__NSID__);</script> </nobr>
		</td>

		<td width="70px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;업무구분</nobr></td>
		<td class="tab18" style="width:150px;" align=center><nobr>&nbsp;
			<comment id="__NSID__"><object  id=gclx_fsdat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				style="position:relative;left:-25px;top:2px;font-size:12px;width:80px;">
					<param name=ComboDataID  value="gcds_comcode01">
					<param name=CBDataColumns	 value="CDCODE,CDNAM">
					<param name=SearchColumn	 value="CDNAM">
					<param name=Sort			     value="false">
					<param name=ListExprFormat value="CDNAM">								
					<param name=BindColumn		 value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
	<tr>
		<td height=7  colspan =8> </td>
  </tr>
</table>


<fieldset id=field1 style="position:absolute;top:76px;left:4px;height:372px;width:860px;bacground-color:#708090"></fieldset>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:5px;width:850px; height:340px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<param name="ColSizing"   value="true">
				<param name="Editable"    value="true">
				<PARAM NAME="Format"			VALUE="  
				<C> Name='선택'		    ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center EditStyle=CheckBox  </C> 
				<C> Name='지점'		    ID=FDNAME 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left	 sort=true  edit=none</C> 
				<C> Name='업무'		    ID=CDNAM  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left	 sort=true  edit=none</C> 
				<C> Name='전표번호'		ID=FSDTNB	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=left	 sort=true	edit=none</C> 
				<C> Name='금액'			  ID=FSAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=right	 sort=true  edit=none</C> 
				<C> Name='적요'			  ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=380	  align=left	 sort=true  edit=none</C> 
				<C> Name='건수'			  ID=CNT       HeadAlign=Center HeadBgColor=#B9D4DC Width=40	  align=right   edit=none</C> 
				<C> Name='상태'		    ID=FSSTAT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=40	  align=center EditStyle=Combo Data='Y:완료,N:대기' edit=none </C> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:5px;width:852px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 