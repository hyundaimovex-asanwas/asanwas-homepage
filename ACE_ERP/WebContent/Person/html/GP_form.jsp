<html>
<body>
<head><title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <Script language="javascript" src="../../common/include/PubFun.js"></script> -->
<script language="javascript">
var ParamMst = new Array();
var ParamDtl = new Array();
</script>
</head>

<form name="appfrm" method="post" action="" target="_ifrm">
<input type="hidden" name="typ" value="">		  <!-- 양식코드 : 양식별로 구분할수 있는 구분자로 양식별로 할당하여 사용할 것임.-->
<input type="hidden" name="eno" value="">	<!-- 기안자 사번 : 기안을 할 사용자의 사번으로 인사시스템에서 만들어 넣어주세요!-->
<!-- 연동에 필요한 XML Data : 기안시 그룹웨어 쪽으로 넘길 실제 Data로 인사 시스템내에서 만들어 넣어주세요!-->
<!-- <input type="hidden" name="xml" value="<?xml version='1.0' encoding='utf-8' ?><returnData RESULT='true'><row><field name='param1'><![CDATA[HA1]]></field><field name='param2'><![CDATA[]]></field><field name='param3'><![CDATA[]]></field><field name='param4'><![CDATA[]]></field><field name='param5'><![CDATA[]]><field name='connurl'><![CDATA[http://203.242.52.66/test/test.jsp]]></field></field><field name='lDepartment'><![CDATA[광양사무소]]></field><field name='workDate'><![CDATA[2007/01/07 ( 日 )]]></field><field name='total'><![CDATA[2]]></field></row><row><field name='empNo'><![CDATA[3607]]></field><field name='lJikwe'><![CDATA[#1]]></field><field name='userName'><![CDATA[김용철]]></field><field name='workStart'><![CDATA[04:00]]></field><field name='workEnd'><![CDATA[06:00]]></field><field name='workContents'><![CDATA[HHSH005W 하역작업 준비]]></field></row><row><field name='empNo'><![CDATA[3940]]></field><field name='lJikwe'><![CDATA[대리급감독]]></field><field name='userName'><![CDATA[서백석]]></field><field name='workStart'><![CDATA[04:00]]></field><field name='workEnd'><![CDATA[06:00]]></field><field name='workContents'><![CDATA[MV ORCHID BAY 702A 선적감독]]></field></row></returnData>"> -->
<input type="hidden" name="xml" value=""> 
<input type="hidden" name="company" value="hda">	<!-- 회사코드 : 회사 구분 코드임.-->
</form>
<iframe id="_ifrm" name="_ifrm" style="width:0;height:0px;border:0 solid #708090;"></iframe>

<script language="javascript">
function ln_Popup(gb,ParamMst,ParamDtl){
<!--
 
 document.appfrm.typ.value=ParamMst[0];
 document.appfrm.eno.value=ParamMst[1];

 var format_mst="";
 var format_dtl="";
 var m=0;
 var s_url = "http://203.242.32.199/services/servlet/";

 if(gb=='HA1'){ //야근특근관리
	 format_mst = "<?xml version='1.0' encoding='utf-8' ?>"
							+ "<returnData RESULT='true'>"                                                   
							+ "<row>"                                                                       
							+ "<field name='param1'><![CDATA[HA1]]></field>"                                
							+ "<field name='param2'><![CDATA[]]></field>"                                   
							+ "<field name='param3'><![CDATA[]]></field>"                                   
							+ "<field name='param4'><![CDATA[]]></field>"                                   
							+ "<field name='param5'><![CDATA[]]></field>"                                           
							+ "<field name='connurl'><![CDATA["+s_url+"Person.hgroup_s1]]></field>"      
							+ "<field name='lDepartment'><![CDATA["+ParamMst[2]+"]]></field>"                    
							+ "<field name='total'><![CDATA["+ParamMst[3]+"]]></field>"                                   
							+ "</row>";

		for(i=1;i<=ParamMst[3];i++){
			format_dtl=format_dtl
							+ "<row>"
							+ "<field name='workDate'><![CDATA["+ParamDtl[0+m]+"]]></field>"     
							+ "<field name='empNo'><![CDATA["+ParamDtl[1+m]+"]]></field>"                                
							+ "<field name='lJikwe'><![CDATA["+ParamDtl[2+m]+"]]></field>"                                 
							+ "<field name='userName'><![CDATA["+ParamDtl[3+m]+"]]></field>"                            
							+ "<field name='workStart'><![CDATA["+ParamDtl[4+m]+"]]></field>"                           
							+ "<field name='workEnd'><![CDATA["+ParamDtl[5+m]+"]]></field>"                             
							+ "<field name='workContents'><![CDATA["+ParamDtl[6+m]+"]]></field>"  
							+ "<field name='Hlno'><![CDATA["+ParamDtl[7+m]+"]]></field>"   
							+ "</row>";
			 m+=8;
		}
		format_dtl=format_dtl+"</returnData>";
		document.appfrm.xml.value=format_mst+format_dtl;
	}else if(gb=='HA2'){ // 국내출장관리
		 format_mst = "<?xml version='1.0' encoding='utf-8' ?>"
								+ "<returnData RESULT='true'>"
								+ "<row>"
								+ "<field name='param1'><![CDATA[HA2]]></field>"												//<!-- 양식코드 -->
								+ "<field name='param2'><![CDATA[]]></field>"													  //<!-- 파라미터2-->
								+ "<field name='param3'><![CDATA[]]></field>"													  //<!-- 파라미터3-->
								+ "<field name='param4'><![CDATA[]]></field>"													  //<!-- 파라미터4-->
								+ "<field name='param5'><![CDATA[]]></field>"													  //<!-- 파라미터5-->
								+ "<field name='connurl'><![CDATA["+s_url+"Person.hgroup_s2]]></field>"		      //<!-- 데이터를 리턴할 URL정보-->
								+ "<field name='location'><![CDATA["+ParamMst[2]+"]]></field>"					//<!-- 출장지 -->
								+ "<field name='propose'><![CDATA["+ParamMst[3]+"]]></field>"						//<!-- 출장목적 -->
								+ "<field name='period'><![CDATA["+ParamMst[4]+"]]></field>"	          //<!-- 출장기간-->
								+ "<field name='totalCost'><![CDATA["+ParamMst[5]+"]]></field>"					//<!-- 출장비합계-->
								+ "<field name='Remark1'><![CDATA["+ParamMst[7]+"]]></field>"			  		//<!-- 비고1-->
								+ "<field name='Remark2'><![CDATA["+ParamMst[8]+"]]></field>"				  	//<!-- 비고2-->
								+ "</row>";

      for(i=1;i<=ParamMst[6];i++){
			 format_dtl=format_dtl
			            + "<row>"
									+ "<field name='DeptName'><![CDATA["+ParamDtl[0+m]+"]]></field>"			//<!-- 부서 -->
									+ "<field name='UserTitle'><![CDATA["+ParamDtl[1+m]+"]]></field>"			//<!-- 직위 -->
									+ "<field name='UserName'><![CDATA["+ParamDtl[2+m]+"]]></field>"			//<!-- 이름 -->
									+ "<field name='workDate'><![CDATA["+ParamDtl[3+m]+"]]></field>"			//<!-- 일자 -->
									+ "<field name='workLocation'><![CDATA["+ParamDtl[4+m]+"]]></field>"	//<!-- 구간 -->
									+ "<field name='TripType'><![CDATA["+ParamDtl[5+m]+"]]></field>"			//<!-- 교통 --> 
									+ "<field name='CostTrip'><![CDATA["+ParamDtl[6+m]+"]]></field>"			//<!-- 교통편 -->
									+ "<field name='CostDay'><![CDATA["+ParamDtl[7+m]+"]]></field>"				//<!-- 숙박비 -->
									+ "<field name='CostFood'><![CDATA["+ParamDtl[8+m]+"]]></field>"			//<!-- 식비 --> 
									+ "<field name='CostDayCost'><![CDATA["+ParamDtl[9+m]+"]]></field>"	  //<!-- 일비 -->
									+ "<field name='CostTotal'><![CDATA["+ParamDtl[10+m]+"]]></field>"		//<!-- 계 -->
									+ "<field name='Hlno'><![CDATA["+ParamDtl[11+m]+"]]></field>"		      //<!-- 출장번호-->
									+ "</row>";
				 m+=12;
      }
		format_dtl=format_dtl+"</returnData>";
		document.appfrm.xml.value=format_mst+format_dtl;
  }else if(gb=='HA3'){ // 해외출장관리
		 format_mst = "<?xml version='1.0' encoding='utf-8' ?>"
								+ "<returnData RESULT='true'>"
								+ "<row>"
								+ "<field name='param1'><![CDATA[HA3]]></field>"			            		//<!-- 양식코드 -->
								+ "<field name='param2'><![CDATA[]]></field>"													//<!-- 파라미터2-->
								+ "<field name='param3'><![CDATA[]]></field>"													//<!-- 파라미터3-->
								+ "<field name='param4'><![CDATA[]]></field>"													//<!-- 파라미터4-->
								+ "<field name='param5'><![CDATA[]]></field>"													//<!-- 파라미터5-->
								+ "<field name='connurl'><![CDATA["+s_url+"Person.hgroup_s3]]></field>"	//<!-- 데이터를 리턴할 URL정보-->
								+ "<field name='location'><![CDATA["+ParamMst[2]+"]]></field>"				//<!-- 출장지 -->
								+ "<field name='propose'><![CDATA["+ParamMst[3]+"]]></field>"					//<!-- 출장목적 -->
								+ "<field name='period'><![CDATA["+ParamMst[4]+"]]></field>"	        //<!-- 출장기간-->
								+ "<field name='totalCost'><![CDATA["+ParamMst[5]+"]]></field>"				//<!-- 출장비합계-->
                + "<field name='exchange'><![CDATA["+ParamMst[6]+"]]></field>"	      //<!-- 출장기간-->
								+ "<field name='Remark1'><![CDATA["+ParamMst[8]+"]]></field>"	      //<!-- 비고1-->
								+ "<field name='Remark2'><![CDATA["+ParamMst[9]+"]]></field>"	      //<!-- 비고2-->
								+ "</row>";

			for(i=1;i<=ParamMst[7];i++){
				format_dtl=format_dtl
								+ "<row>"
								+ "<field name='DeptName'><![CDATA["+ParamDtl[0+m]+"]]></field>"			//<!-- 부서 -->
								+ "<field name='UserTitle'><![CDATA["+ParamDtl[1+m]+"]]></field>"			//<!-- 직위 -->
								+ "<field name='UserName'><![CDATA["+ParamDtl[2+m]+"]]></field>"			//<!-- 성명 -->
								+ "<field name='workDate'><![CDATA["+ParamDtl[3+m]+"]]></field>"			//<!-- 기간 -->
								+ "<field name='daycount'><![CDATA["+ParamDtl[4+m]+"]]></field>"			//<!-- 일수 -->
								+ "<field name='TripCost'><![CDATA["+ParamDtl[5+m]+"]]></field>"			//<!-- 출장비 -->
								+ "<field name='CostFood'><![CDATA["+ParamDtl[6+m]+"]]></field>"			//<!-- 식비 -->
								+ "<field name='CostTrip'><![CDATA["+ParamDtl[7+m]+"]]></field>"			//<!-- 교통비 -->
								+ "<field name='CostTotal'><![CDATA["+ParamDtl[8+m]+"]]></field>"	  	//<!-- 합계 -->
								+ "<field name='Hlno'><![CDATA["+ParamDtl[9+m]+"]]></field>"		      //<!-- 출장번호-->
							  + "</row>";
				m+=10;
			}
    
		format_dtl=format_dtl+"</returnData>";
		document.appfrm.xml.value=format_mst+format_dtl;
	}else if(gb=='HA4'){ //근태신청관리
		 format_mst = "<?xml version='1.0' encoding='utf-8' ?>"
								+ "<returnData RESULT='true'>"
								+ "<row>"
								+ "<field name='param1'><![CDATA[HA4]]></field>"									  //<!-- 양식코드 -->
								+ "<field name='param2'><![CDATA["+ParamMst[7]+"]]></field>"		    //<!-- 파라미터2 신청일 넘겨줬다가 받음-->
								+ "<field name='param3'><![CDATA[]]></field>"										    //<!-- 파라미터3 사번 받음-->
								+ "<field name='param4'><![CDATA[]]></field>"										    //<!-- 파라미터4 근태코드 받음-->
								+ "<field name='param5'><![CDATA[]]></field>"										    //<!-- 파라미터5 근태시작일 받음-->
								+ "<field name='param6'><![CDATA[]]></field>"										    //<!-- 파라미터6 return flag 받음-->
								+ "<field name='connurl'><![CDATA["+s_url+"Person.hgroup_s4]]></field>"	  //<!-- 데이터를 리턴할 URL정보-->
								//+ "<field name='connurl'><![CDATA[http://203.242.52.78/test/test_result.jsp]]></field>"	    //<!-- 데이터를 리턴할 URL정보-->
                //+ "<field name='connurl'><![CDATA[http://203.242.32.199/services/test_Result.jsp]]></field>"
								+ "<field name='DeptName'><![CDATA["+ParamMst[2]+"]]></field>"			//<!-- 부서  -->
								+ "<field name='UserNo'><![CDATA["+ParamMst[3]+"]]></field>"				//<!-- 사번 -->
								+ "<field name='UserTitle'><![CDATA["+ParamMst[4]+"]]></field>"			//<!-- 직위 -->
								+ "<field name='UserName'><![CDATA["+ParamMst[5]+"]]></field>"			//<!-- 성명 -->
								+ "</row>";		
			for(i=1;i<=ParamMst[6];i++){
				format_dtl=format_dtl
								+ "<row>"
								+ "<field name='GunTaeStart'><![CDATA["+ParamDtl[0+m]+"]]></field>"		//<!-- 시작일 -->
								+ "<field name='GunTaeEnd'><![CDATA["+ParamDtl[1+m]+"]]></field>"			//<!-- 종료일 -->
								+ "<field name='GunTaeType'><![CDATA["+ParamDtl[2+m]+"]]></field>"		//<!-- 근태 -->
								+ "<field name='GunTaeSaYu'><![CDATA["+ParamDtl[3+m]+"]]></field>"		//<!-- 사유 -->
								+ "<field name='Hlno'><![CDATA["+ParamDtl[4+m]+"]]></field>"	  	    //<!-- HLNO -->
							    + "</row>";
					m+=5;
			}

		format_dtl=format_dtl+"</returnData>";
		document.appfrm.xml.value=format_mst+format_dtl;
	}
	//prompt("",document.appfrm.xml.value);
  //호출
	document.appfrm.action = "http://ekpd.hmm21.com/Login_ApprovalNA.aspx";
	document.appfrm.submit();
//-->
}
</script>

</body>
</html>