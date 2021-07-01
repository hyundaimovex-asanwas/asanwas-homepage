<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>차량예약>배차확인
* 프로그램 ID	: lc095.jsp
* 기 능 정 의	: 배차신청
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2017.7.7
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>배차확인</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


	var strParam = new Array();	//팝업시 받아오는 파라미터들

	strParam=window.dialogArguments;
	
	var car;
	
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(){
		
			gcem_staxdate.text		= strParam[0];  //날짜
		
			if(strParam[1] == 'G'){
				txt_car_nm.value 		= '그랜져';  	
			}else if(strParam[1] == 'S'){
				txt_car_nm.value		    = '스타렉스';  
			}else if(strParam[1] == 'A'){
				txt_car_nm.value		    = '코나';  
			}else if(strParam[1] == 'C'){
				txt_car_nm.value		    = '카니발';  
			}
			
    		fnSelect();   	  

}


/******************************************************************************
	Description : 조회 - 
******************************************************************************/
function fnSelect() {

		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_staxdate.text
	     																			 + ",v_car=" + strParam[1];	 	 

	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc095",  "JSP(O:DS_DEFAULT=ds_default)",  param);
	
	    //prompt(this, param);

	    tr_post(tr1);

}



/******************************************************************************
Description : BlackList 관리
******************************************************************************/
function fn_Noshow() {

		var eno_no = ds_default.namevalue(ds_default.rowPosition,"ENO_NO");
		var eno_nm = ds_default.namevalue(ds_default.rowPosition,"ENO_NM");

		if (ds_default2.CountColumn == 0) {
			ds_default2.setDataHeader("ENO_NO:STRING");
		}
		
		// 행 추가
		ds_default2.AddRow();		
		
		ds_default2.namevalue(1,"ENO_NO") = eno_no;	 		
		
		if(confirm(eno_nm+"에 대해 오늘부터 1달간 미사용 처리를 하시겠습니까?")){		
		
		    ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc095",  "JSP(I:DS_DEFAULT2=ds_default2)",  "proType=A, dsType=1");

		    //prompt(this, ds_default2.text);
		       
		    tr_post(tr2);
		    
		}

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
</script>


<script language=JavaScript for=tr2  event=OnSuccess()>

	alert("정상적으로 처리되었습니다.");

	window.close();
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<body onLoad="fnOnLoad();">


<br>

<table border="0" cellpadding="0" cellspacing="0" width=99%>
	<tr>
		<td class="r">
			<img src="<%=dirPath%>/Security/common/img/com_b_noshow.gif"		style="cursor:hand" onclick="fn_Noshow()">
		</td>
	</tr>
</table>

<br>

<table>
	<tr> 
		<td>
			<table border="0" cellpadding="0" cellspacing="0" >
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;신청일자&nbsp;&nbsp;</td>
				<td style="border:1 solid #708090;border-width:1 1 1 0;" class="m l">&nbsp;&nbsp;
					<object  id=gcem_staxdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;top:2px;">		
						<param name=Text						value="">
						<param name=Alignment     			value=0>
						<param name=Border          			value=true>
						<param name=Numeric       			value=false>
						<param name=Format          			value="####-##-##">
						<param name=PromptChar  				value="">
						<param name=BackColor     			value="#CCCCCC">  
						<param name=InheritColor   			value=false>
						<param name=readOnly       			value=true>
						<param name=ReadOnlyBackColor   	value="#d7d7d7">
				   </object>&nbsp;			
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;신청차량&nbsp;&nbsp;</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_car_nm" class="txtbox" type="text" style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>
			</table>
		</td>
	</tr>
</table>

<table width="780px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:780px; height:250px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 	value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="30">
                    <param name="SuppressOption"   value="1">						
					<param name="Format"	 	 		value=" 
					<C> Name='No'			ID={CUROW}	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center	value={String(Currow)}</C>
					<C> Name='시간'      	ID=TIME 	  	    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	    align=center	</C>                  
					<C> Name='목적지'       ID=DESTINATION	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	align=center </C> 
					<C> Name='직위'         ID=JOB_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center </C>
					<C> Name='사번'         ID=ENO_NO			HeadAlign=Center HeadBgColor=#B9D4DC Width=60 		align=center </C>										                   
					<C> Name='성명'         ID=ENO_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=60 		align=center </C>
					<C> Name='배차사유'    ID=SAYU				HeadAlign=Center HeadBgColor=#B9D4DC Width=300 	align=left </C>  					                    
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
</table> 

</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_DEFAULT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   		Value="ds_default">
	<Param Name="BindInfo", 		Value='

		<C>Col=ENO_NO				Ctrl=txt_empno   					Param=text			</C>		
		<C>Col=ENO_NM				Ctrl=txt_empnmk   				Param=value			</C>	
		<C>Col=FROM_TM				Ctrl=gclx_starttime	   				Param=BindColVal	</C>
		<C>Col=TO_TM   		 		Ctrl=gclx_endtime	 				Param=BindColVal	</C>			
		<C>Col=SAYU				    Ctrl=txt_sayu	   						Param=value			</C>	
		<C>Col=DESTINATION		Ctrl=txt_destination	   			Param=value			</C>
		<C>Col=FELLOW				Ctrl=gclx_fellow	   					Param=BindColVal	</C>
		<C>Col=CARGO   		 		Ctrl=gclx_cargo	 					Param=BindColVal	</C>
		<C>Col=EM_PHN_NO			Ctrl=txt_phone_no	   				Param=value			</C>
		<C>Col=REMARK				Ctrl=txt_remark	   					Param=value			</C>

    '>
</object>

