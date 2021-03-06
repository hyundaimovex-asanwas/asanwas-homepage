<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 반제정산 list
+ 프로그램 ID	:  A030015_popup.html
+ 기 능 정 의	:  반제처리
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.10.21
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
<title>반제내역</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
//get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_fdcode="";
var gs_fsdat="";
var gs_fsnbr="";
var gs_seq="";
var gs_userid = gusrid;
var g_date_fr = gcurdate.substring(0,4)+"0101";
var g_gubun="N";   //반제취소 적용 
var strParam = new Array();
strParam=window.dialogArguments;

function ln_Start(){

	ln_Query(strParam[0],strParam[1],strParam[2],strParam[3]);	  
	gcem_fdcode.text=strParam[4];//지점명
	gcem_fsdatnbr.text=strParam[5];  //전표번호
	gcem_atcodenm.text=strParam[12]+' - '+strParam[6];  //계정명
	gcem_chaamt.text=strParam[7];  //차변금액
	gcem_daeamt.text=strParam[8];  //대변금액
	gcem_janamt.text=strParam[9];  //잔액
	gcem_vendnm.text=strParam[13]+' - '+strParam[10]; //거래처명
	txt_remark.value=strParam[11]; //적요
	gcem_bjanamt.text=strParam[14];  //승인잔액
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(p1,p2,p3,p4){
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s2?v_str1="+p1
																		  +"&v_str2="+p2
																		  +"&v_str3="+p3
																	  	  +"&v_str4="+p4;
										
	//prompt("gcds_data01",gcds_data01.DataID);
	gcds_data01.Reset();
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Before(){
	//관리항목[검색]
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050&v_str2=";  
	gcds_fsrefcd.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Before2(){
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?v_str1="+txt_atcode_fr.value
	                                                  +"&v_str2="+txt_atcodenm_fr.value
	                                                  +"&v_str3=&v_str4=ATUSEYN"
																										+"&v_str5=ATDEBTYN&v_str6="; 
	//prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 반제조회 -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
	if(gcds_data01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}

	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
</script>


<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a030015_popup_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:140px;" ><nobr>&nbsp;<comment id="__NSID__">
				 <object  id=gcem_fdcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표번호&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_fsdatnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;계정과목&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:240px;" colspan =3><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_atcodenm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:420px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=GeneralEdit   value="true">
						<param name=Border        value=true>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td> 
		</tr>
		<tr>   
		  <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;차변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
					<object  id=gcem_chaamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
		  </td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;대변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_daeamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>

      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;잔액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_janamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;승인잔액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_bjanamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
     

		</tr>
		<tr>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;적요&nbsp;</nobr></td>
			<td class="tab19" style="width:280px;height:30px" colspan=5><nobr>&nbsp;
				<input id="txt_remark" type="text" class="txtbox" readOnly=true  style= "position:relative;top:0px;left:-4px;width:490px; height:20px;background-color:#d7d7d7" maxlength="60" bgColor="#D7D7D7"  >
				</nobr>
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;거래처&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:260px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:220px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=GeneralEdit   value="true">
						<param name=Border        value=true>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>

		</tr>
		<tr>
			<td height=3  colspan =8> </td>
		</tr>
	</table>

<fieldset id=field1 style="position:absolute;top:142px;left:4px;height:310px;width:860px;bacground-color:#708090"></fieldset>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:5px;top:5px;width:850px; height:280px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<param name="ColSizing"   value="true">
				<param name="Editable"    value="false">
				<param name="ViewSummary"	value=1>
				<PARAM NAME="Format"			VALUE="              
					<C> Name='상태'		        ID=FSSTAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=58	  align=center	 SumBgColor=#C3D0DB sort=true EditStyle=Combo Data='N:결재대기,Y:결재완료,C:결재취소,B:반송,R:결재요청' edit=none </C> 
					<C> Name='반제전표번호'		ID=SSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB sort=true	edit=none sumText='합 계' </C> 
					<C> Name='순번'		        ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center   SumBgColor=#C3D0DB edit=none show =false</C> 
					<C> Name='차변'			      ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	   SumBgColor=#C3D0DB edit=none  SumColor=#0000FF color=#0000FF sumText=@sum </C> 
					<C> Name='대변'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB edit=none  SumColor=#FF0000 color=#FF0000 sumText=@sum </C> 
					<C> Name='적요'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=250	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='거래처'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	sort=true edit=none  </C> 
					<C> Name='관리항목'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	edit=none  </C> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:5px;top:5px;width:852px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</tr>
</table>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 