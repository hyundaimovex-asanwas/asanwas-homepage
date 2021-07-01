<!--
***********************************************************************
* @source      : guna071.jsp
* @description : 근태현황 결재처리 - 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/20      권혁수        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
%>
<html>
<head>
	<title>근태현황 결재처리 - 결재세부사항(guna071)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//alert(dsTemp.NameValue(1,"REQ_NO"));
            //결재세부사항 조회(변경신청)
            if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_01&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
                dsT_DI_CHANGE.reset();
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="C"){//일일근태
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_02&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO");
                dsT_DI_CHANGE.reset();
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="P"){//익월근태
				/*
				alert("죄송합니다 시스템 점검중입니다");
				window.close();
				*/
				trT_DI_CHANGE.KeyValue = "JSP(O:DS_ONE=dsT_DI_CHANGE, O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY)";
				trT_DI_CHANGE.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_PLAN&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_CHANGE.post();
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){//연차촉진제
				trT_DI_CHANGE.KeyValue = "JSP( O:dsT_DI_ACCELERATE=dsT_DI_CHANGE,O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY)";
				trT_DI_CHANGE.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_ACC&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_CHANGE.post();
/*
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_PLAN&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
                dsT_DI_CHANGE.reset();
*/
            }
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {
            if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "일일근태";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"REQ_YMD");
                document.getElementById("txtGUN_GBN").value = "변경신청";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="R"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "대체근무";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "익월근태";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "연차촉진제";
            }
            if(dsTemp.NameValue(1,"APP_TIME")!=""){
                document.getElementById("txtUPT_YMD").value = dsTemp.NameValue(1,"APP_TIME");
				document.getElementById("txtREMARK").value = dsTemp.NameValue(1,"REMARK");
				document.getElementById("txtREMARK").className = "input_ReadOnly";
				document.getElementById("txtREMARK").readOnly = true;
			}else{
                document.getElementById("append_btn").style.display = "";
            }
			if(dsTemp.NameValue(1,"APP_TIME")!=""){
				document.getElementById("append_btn").style.display = "none";
			}else{
				document.getElementById("append_btn").style.display = "";
			}
			// 결재자만 버튼이 활성화
            if(dsTemp.NameValue(1,"ENO_NO")!= "<%=eno_no%>"){
                document.getElementById("append_btn").style.display = "none";
            }else{

            }

            var nowDate = getToday().replace("-","").replace("-","");
            //var gunDate = (document.getElementById("txtGUN_YMD").value).replace("-","").replace("-","");
/*
			//일일근태는 당일 9시 이전에만 결재가능(임시 주석, 김우태 대리, 20070905)
            if(dsTemp.NameValue(1,"GUN_GBN")=="C" && (new Date().getHours() >= "9" || nowDate != gunDate) ){
			   document.getElementById("append_btn").style.display = "none";

			//근태변경는 30일 이전에만 결재가능(임시 주석, 김우태 대리, 20070905)
			}else if(dsTemp.NameValue(1,"GUN_GBN")=="U" && parseInt(cfDateDiff(gunDate, nowDate)) >30){
				document.getElementById("append_btn").style.display = "none";
			}
*/
            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {
			if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=100	name="소속"		align=center	</C> '
                							+ '<C> id="JOB_NM"	width=70	name="직위"		align=center    </C> '
                							+ '<C> id="ENO_NO"	width=70	name="사번"		align=center	</C> '
                							+ '<C> id="ENO_NM"	width=100	name="성명"		align=center	</C> '
                							+ '<C> id="GUN_CD"	width=100	name="근태"	    align=center	VALUE={DECODE(GUN_CD,"()","",GUN_CD)}</C>   '
                							+ '<C> id="PIS_YYMMDD"	width=100	name="근태일자"	align=center	Mask="XXXX-XX-XX"	</C> '
                							+ '<C> id="REMARK"	width=140	name="사유"	    align=left	    </C>';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=80	name="소속"		align=center	</C>  '
                                            + '<C> id="JOB_NM"	width=70	name="직위"		align=center    </C>  '
                                            + '<C> id="ENO_NO"	width=50	name="사번"		align=center	</C>  '
                                            + '<C> id="ENO_NM"	width=60	name="성명"		align=center	</C>  '
                                            + '<G> name="변경전근태"  HeadBgColor="#F7DCBB"                       '
											+ '    <C> id="REQ_YMD"	    width=80	name="근태일"	align=center Mask="XXXX-XX-XX"  </C> '
                                            + '    <C> id="BF_GUN_CD"	width=80	name="근태"	align=center  VALUE={DECODE(BF_GUN_CD,"()","",BF_GUN_CD)}  </C> '
                                            + '    <C> id="BF_REMARK"	width=100	name="사유"	align=left	    </C> '
                                            + '</G>'
                                            + '<G> name="변경후근태"  HeadBgColor="#F7DCBB"                       '
                                            + '<C> id="GUN_CD"		width=80	name="근태"	align=center  VALUE={DECODE(GUN_CD,"()","",GUN_CD)} 	</C>  '
											+ '<C> id="CHN_YMD"	    width=80	name="근태일"	align=center  Mask="XXXX-XX-XX" </C> '
                                            + '<C> id="REASON"		width=100	name="사유"	align=left	    </C>  '
                                            + '</G>';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
				var IndexColCnt     = dsT_DI_CHANGE.CountColumn;       //칼럼 총 개수
				
				// 가져온 데이타셋에서 그리드상 고정 헤더부분을 제외한 가변부분(날짜) 에대한 개수
				// 칼럼총개수 - 앞컬럼개수 - 뒤컬럼
				var Dm_ColCnt   = IndexColCnt - 7;       
				var req_no = dsTemp.NameValue(1,"REQ_NO")    // 시작일자의 월
				//alert(next_month(req_no.substring(0,4)+"-"+req_no.substring(4,6)));

				str_m = (next_month(req_no.substring(0,4)+"-"+req_no.substring(4,6))).substring(5);
				//var str_m = dsTemp.NameValue(1,"REQ_NO").substr(4,2);    // 시작일자의 월
				if ( str_m.substr(0,1) == '0' ) {
					str_m = str_m.substr(1,1);
				}


				var str_d;
				var Fix_Col  = "<FC>id={CUROW}	 name=NO             width=30 	align=center               HeadBgColor='#F7DCBB'    value={String(Currow)} </FC>" +
							   "<FC>id=JOB_NM    name=직위           width=35   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //1번컬럼
							   "<FC>id=ENO_NO    name=사번           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //2번컬럼
							   "<FC>id=ENO_NM    name=성명           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //3번컬럼
							   "<FC>id=YRP_CNT   name='발생;연차'    width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //4번컬럼
							   "<FC>id=NYRP_CNT  name='미사용;연차'  width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //5번컬럼
							   "<FC>id=REM_CNT   name='잔여'         width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" ; //6번컬럼

				var Dm_Col = "";   // day 에 해당하는 칼럼(조건에따라 개수가 변하는 칼럼)

				//**********************     day 에 해당하는 칼럼 총 개수만큼 실행하여 grid 나머지 헤더부분을 생성한다.
				for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
				{
					if ( dsT_DI_CHANGE.ColumnID(i).length == '29' )     // 1~9까지일경우 칼럼문자길이가 29 , 11~일경우 칼럼문자길이가 30
					{
						str_d = dsT_DI_CHANGE.ColumnID(i).substr(23,1);
						if ( i == 7 ) 															// 표기될 첫달
							Dm_Col = Dm_Col + "<G>name="+ str_m +"월 HeadBgColor='#F7DCBB'";
						else if ( dsT_DI_CHANGE.ColumnID(i).substr(23,1) == '1' )
							Dm_Col = Dm_Col + "<G>name="+ ++str_m +"월 HeadBgColor='#F7DCBB'";
						if ( dsT_DI_CHANGE.ColumnID(i+1) == '1' )
							Dm_Col = Dm_Col + "</G>";
					}
					else if (  dsT_DI_CHANGE.ColumnID(i).length == '30' )
					{
						str_d = dsT_DI_CHANGE.ColumnID(i).substr(23,2);
					}
						
					Dm_Col = Dm_Col + "<C>id='"+dsT_DI_CHANGE.ColumnID(i)+"'  name="+str_d+"  width=25  align=center edit=AlphaUpper show=true Language=0</C> ";
				}

				form1.grdT_DI_CHANGE.Format = Fix_Col + Dm_Col;
           }else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
			  form1.grdT_DI_CHANGE.Format = "" +
"	<FC> id='{CUROW}'			width=34			name='NO'			align=center			value={String(Currow)}		</FC>	"+
"	<FC> id='DPT_NM'			width=80			name='소속'			align=center			Edit=None					</FC>   "+
"	<FC> id='JOB_NM'			width=50			name='직위'			align=center			Edit=None					</FC>   "+
"	<FC> id='ENO_NO'			width=60			name='사번'			align=center			Edit=None					</FC>   "+
"	<FC> id='ENO_NM'			width=60			name='성명'			align=center			Edit=None					</FC>    "+
"                     <C> id='YRP_REM'			width=50			name='미사용;연차'	align=center			Edit=None					</C>        "+
"                     <C> id='REM_CNT'		    width=40			name='잔여'	        align=center			Edit=None			Value={YRP_REM-(ATT_OCT+ATT_NOV+ATT_DEC)}	</C>      "+
"                     <G> name='10월'  HeadBgColor='#F7DCBB'                                                                                                                              "+
"		<C> id='AT1_OCT'		width=20		name='1'				align=center			Show=false		</C>                 "+
"		<C> id='AT2_OCT'		width=20		name='2'				align=center			Show=false		</C>                 "+
"                         <C> id='AT3_OCT'		width=20		name='3'				align=center			Show=false		</C>  "+
"		<C> id='AT4_OCT'		width=20		name='4'				align=center			Show=false		</C>                  "+
"                         <C> id='AT5_OCT'		width=20		name='5'				align=center			Show=false		</C>            "+
"		<C> id='AT6_OCT'		width=20		name='6'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT7_OCT'		width=20		name='7'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT8_OCT'		width=20		name='8'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT9_OCT'		width=20		name='9'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT10_OCT'		width=20		name='10'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT11_OCT'		width=20		name='11'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT12_OCT'		width=20		name='12'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT13_OCT'		width=20		name='13'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT14_OCT'		width=20		name='14'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT15_OCT'		width=20		name='15'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT16_OCT'		width=20		name='16'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT17_OCT'		width=20		name='17'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT18_OCT'		width=20		name='18'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT19_OCT'		width=20		name='19'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT20_OCT'		width=20		name='20'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT21_OCT'		width=20		name='21'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT22_OCT'		width=20		name='22'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT23_OCT'		width=20		name='23'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT24_OCT'		width=20		name='24'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT25_OCT'		width=20		name='25'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT26_OCT'		width=20		name='26'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT27_OCT'		width=20		name='27'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT28_OCT'		width=20		name='28'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT29_OCT'		width=20		name='29'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT30_OCT'		width=20		name='30'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT31_OCT'		width=20		name='31'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT1_OCT_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_OCT,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT2_OCT_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_OCT,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT3_OCT_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_OCT,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT4_OCT_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_OCT,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT5_OCT_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_OCT,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT6_OCT_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_OCT,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT7_OCT_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_OCT,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT8_OCT_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_OCT,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT9_OCT_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_OCT,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT10_OCT_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_OCT,'H','#F2AC47','#FEEFEF')} </C>                                             "+
"                         <C> id='AT11_OCT_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_OCT_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_OCT_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_OCT_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_OCT_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_OCT_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_OCT_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_OCT_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_OCT_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_OCT_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_OCT_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_OCT_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT23_OCT_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT24_OCT_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT25_OCT_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT26_OCT_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT27_OCT_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT28_OCT_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT29_OCT_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT30_OCT_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT31_OCT_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_OCT,'H','#F2AC47','#FEEFEF')} </C>                       "+
"	</G>                                                                                                                                                                                    "+
"                     <G> name='11월'  HeadBgColor='#F7DCBB'                                                                                                                              "+
"		<C> id='AT1_NOV'		width=20		name='1'				align=center			Show=false		</C>                                                                                                  "+
"		<C> id='AT2_NOV'		width=20		name='2'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT3_NOV'		width=20		name='3'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT4_NOV'		width=20		name='4'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT5_NOV'		width=20		name='5'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT6_NOV'		width=20		name='6'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT7_NOV'		width=20		name='7'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT8_NOV'		width=20		name='8'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT9_NOV'		width=20		name='9'				align=center			Show=false		</C>                                                                            "+
"		<C> id='AT10_NOV'		width=20		name='10'				align=center			Show=false		</C>                                                                                                  "+
"                         <C> id='AT11_NOV'		width=20		name='11'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT12_NOV'		width=20		name='12'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT13_NOV'		width=20		name='13'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT14_NOV'		width=20		name='14'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT15_NOV'		width=20		name='15'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT16_NOV'		width=20		name='16'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT17_NOV'		width=20		name='17'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT18_NOV'		width=20		name='18'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT19_NOV'		width=20		name='19'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT20_NOV'		width=20		name='20'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT21_NOV'		width=20		name='21'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT22_NOV'		width=20		name='22'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT23_NOV'		width=20		name='23'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT24_NOV'		width=20		name='24'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT25_NOV'		width=20		name='25'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT26_NOV'		width=20		name='26'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT27_NOV'		width=20		name='27'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT28_NOV'		width=20		name='28'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT29_NOV'		width=20		name='29'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT30_NOV'		width=20		name='30'				align=center			Show=false		</C>                                                                            "+
"                         <C> id='AT1_NOV_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_NOV,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT2_NOV_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_NOV,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT3_NOV_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_NOV,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT4_NOV_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_NOV,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT5_NOV_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_NOV,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT6_NOV_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_NOV,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT7_NOV_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_NOV,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT8_NOV_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_NOV,'H','#F2AC47','#FEEFEF')} </C>                                              "+
"                         <C> id='AT9_NOV_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_NOV,'H','#F2AC47','#FEEFEF')} </C>                        "+
"		<C> id='AT10_NOV_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_NOV,'H','#F2AC47','#FEEFEF')} </C>                                             "+
"                         <C> id='AT11_NOV_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_NOV_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_NOV_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_NOV_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_NOV_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_NOV_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_NOV_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_NOV_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_NOV_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_NOV_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_NOV_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_NOV,'H','#F2AC47','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_NOV_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_NOV,'H','#F2AC47','#FEEFEF')} </C>          "+
"                         <C> id='AT23_NOV_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_NOV,'H','#F2AC47','#FEEFEF')} </C>          "+
"                         <C> id='AT24_NOV_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_NOV,'H','#F2AC47','#FEEFEF')} </C>          "+
"                         <C> id='AT25_NOV_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_NOV,'H','#F2AC47','#FEEFEF')} </C>            "+
"                         <C> id='AT26_NOV_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_NOV,'H','#F2AC47','#FEEFEF')} </C>           "+
"                         <C> id='AT27_NOV_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_NOV,'H','#F2AC47','#FEEFEF')} </C>           "+
"                         <C> id='AT28_NOV_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_NOV,'H','#F2AC47','#FEEFEF')} </C>          "+
"                         <C> id='AT29_NOV_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_NOV,'H','#F2AC47','#FEEFEF')} </C>          "+
"                         <C> id='AT30_NOV_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_NOV,'H','#F2AC47','#FEEFEF')} </C>            "+
"	</G>                                                                                                                                                "+
"                     <G> name='12월'  HeadBgColor='#F7DCBB'                                                                                          "+
"		<C> id='AT1_DEC'		width=20		name='1'				align=center			Show=false		</C>                                      "+
"		<C> id='AT2_DEC'		width=20		name='2'				align=center			Show=false		</C>                                            "+
"                         <C> id='AT3_DEC'		width=20		name='3'				align=center			Show=false		</C>                  "+
"		<C> id='AT4_DEC'		width=20		name='4'				align=center			Show=false		</C>                                        "+
"                         <C> id='AT5_DEC'		width=20		name='5'				align=center			Show=false		</C>                  "+
"		<C> id='AT6_DEC'		width=20		name='6'				align=center			Show=false		</C>                                       "+
"                         <C> id='AT7_DEC'		width=20		name='7'				align=center			Show=false		</C>                    "+
"		<C> id='AT8_DEC'		width=20		name='8'				align=center			Show=false		</C>                                    "+
"                         <C> id='AT9_DEC'		width=20		name='9'				align=center			Show=false		</C>                   "+
"		<C> id='AT10_DEC'		width=20		name='10'				align=center			Show=false		</C>                                    "+
"                         <C> id='AT11_DEC'		width=20		name='11'				align=center			Show=false		</C>                      "+
"                         <C> id='AT12_DEC'		width=20		name='12'				align=center			Show=false		</C>                "+
"                         <C> id='AT13_DEC'		width=20		name='13'				align=center			Show=false		</C>               "+
"                         <C> id='AT14_DEC'		width=20		name='14'				align=center			Show=false		</C>                  "+
"                         <C> id='AT15_DEC'		width=20		name='15'				align=center			Show=false		</C>               "+
"                         <C> id='AT16_DEC'		width=20		name='16'				align=center			Show=false		</C>             "+
"                         <C> id='AT17_DEC'		width=20		name='17'				align=center			Show=false		</C>                "+
"                         <C> id='AT18_DEC'		width=20		name='18'				align=center			Show=false		</C>               "+
"                         <C> id='AT19_DEC'		width=20		name='19'				align=center			Show=false		</C>                  "+
"                         <C> id='AT20_DEC'		width=20		name='20'				align=center			Show=false		</C>                   "+
"                         <C> id='AT21_DEC'		width=20		name='21'				align=center			Show=false		</C>                  "+
"                         <C> id='AT22_DEC'		width=20		name='22'				align=center			Show=false		</C>                     "+
"                         <C> id='AT23_DEC'		width=20		name='23'				align=center			Show=false		</C>                "+
"                         <C> id='AT24_DEC'		width=20		name='24'				align=center			Show=false		</C>                      "+
"                         <C> id='AT25_DEC'		width=20		name='25'				align=center			Show=false		</C>                         "+
"                         <C> id='AT26_DEC'		width=20		name='26'				align=center			Show=false		</C>                       "+
"                         <C> id='AT27_DEC'		width=20		name='27'				align=center			Show=false		</C>                  "+
"                         <C> id='AT28_DEC'		width=20		name='28'				align=center			Show=false		</C>                  "+
"                         <C> id='AT29_DEC'		width=20		name='29'				align=center			Show=false		</C>                  "+
"                         <C> id='AT30_DEC'		width=20		name='30'				align=center			Show=false		</C>                    "+
"                         <C> id='AT31_DEC'		width=20		name='31'				align=center			Show=false		</C>                      "+
"                         <C> id='AT1_DEC_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_DEC,'H','#F2AC47','#FEEFEF')} </C>     "+
"		<C> id='AT2_DEC_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_DEC,'H','#F2AC47','#FEEFEF')} </C>                         "+
"                         <C> id='AT3_DEC_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_DEC,'H','#F2AC47','#FEEFEF')} </C>     "+
"		<C> id='AT4_DEC_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_DEC,'H','#F2AC47','#FEEFEF')} </C>                         "+
"                         <C> id='AT5_DEC_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_DEC,'H','#F2AC47','#FEEFEF')} </C>     "+
"		<C> id='AT6_DEC_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_DEC,'H','#F2AC47','#FEEFEF')} </C>                         "+
"                         <C> id='AT7_DEC_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"		<C> id='AT8_DEC_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_DEC,'H','#F2AC47','#FEEFEF')} </C>                           "+
"                         <C> id='AT9_DEC_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"		<C> id='AT10_DEC_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_DEC,'H','#F2AC47','#FEEFEF')} </C>                          "+
"                         <C> id='AT11_DEC_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT12_DEC_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT13_DEC_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT14_DEC_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT15_DEC_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT16_DEC_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT17_DEC_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT18_DEC_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_DEC,'H','#F2AC47','#FEEFEF')} </C>      "+
"                         <C> id='AT19_DEC_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT20_DEC_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT21_DEC_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT22_DEC_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_DEC,'H','#F2AC47','#FEEFEF')} </C>        "+
"                         <C> id='AT23_DEC_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT24_DEC_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT25_DEC_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT26_DEC_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT27_DEC_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT28_DEC_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT29_DEC_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT30_DEC_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"                         <C> id='AT31_DEC_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_DEC,'H','#F2AC47','#FEEFEF')} </C>       "+
"	</G>                                                                                                                                                                                    ";
		   }
			cfStyleGrid(form1.grdT_DI_CHANGE,15,"false","false");
		}

        /********************************************
         * 17. 승인, 기각 버튼 처리					*
         ********************************************/
		function fnc_Append(yn_var) {

            var msg = "";
			
            if(yn_var == "Y"){
                msg = "결재처리를";
            }else{
				if(document.getElementById("txtREMARK").value == ""){
					alert("부결사유를 입력하세요");
					document.getElementById("txtREMARK").focus();
					return false;
				}
                msg = "부결처리를";
            }

            if (confirm(msg+" 하시겠습니까?")) {

				dsT_DI_CHANGE.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE)";

				// DPT_CD 가져오는 차이
				// 가변적으로  Column을 가져와야함으로 DPT_CD을 안가져옴....
				// 그러나 나머지것은 다른 부서것을 가져올수도 있게 하였음....
				 if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
					trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
					trT_DI_APPROVAL.post();
				 }else{
					trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value+"&DPT_CD="+dsT_DI_CHANGE.NameValue(1,"DPT_CD");
					trT_DI_APPROVAL.post();
				 }
            }

            window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_CHANGE)		   |
    | 3. 사용되는 Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet (휴일날짜 표시)     |
    | 2. 이름 : dsT_DI_PLAN04                     |
    | 3. Table List : T_DI_HOLIDAY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_PLAN)		|
    | 3. 사용되는 Table List(T_DI_PLAN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_CHANGE=T_DI_CHANGE)">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
		fnc_ChangeGrid();//그리드 변경 처리
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
		if(dsTemp.NameValue(1,"GUN_GBN")=="P"){
			var IndexColCnt     = dsT_DI_CHANGE.CountColumn;       //칼럼 총 개수
					
			// 가져온 데이타셋에서 그리드상 고정 헤더부분을 제외한 가변부분(날짜) 에대한 개수
			// 칼럼총개수 - 앞컬럼개수 - 뒤컬럼
			var Dm_ColCnt   = IndexColCnt - 6 - 4;       
			//휴일 설정(토요일, 일요일)
			for ( var i = 7; i <= Dm_ColCnt + 6; i++ ){
				if ( dsT_DI_HOLIDAY.NameValue(i-6,"HOL_YN") == "Y" ){ 
					holiday_color = "#F47380";//휴일
					form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'Edit') = 'none';
				}else{
					holiday_color = "#F7DCBB";
					form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'Edit') = 'AlphaUpper';
				}
				form1.grdT_DI_CHANGE.ColumnProp(dsT_DI_CHANGE.ColumnID(i), 'HeadBgColor') = holiday_color;
			}
		}else if(dsTemp.NameValue(1,"GUN_GBN")=="A"){
            //휴일 설정(토요일, 일요일)
			for(i=1;i<=iCount;i++){
                grdT_DI_CHANGE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM")+"_V", 'HeadBgColor') = "#F47380";
                grdT_DI_CHANGE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM"), 'edit') = "none";
            }
		}


    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
        document.getElementById("append_btn").style.display = "none";
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태현황 결재처리 - 결재세부사항</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">근태현황 결재처리 - 결재세부사항</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
                <span id="append_btn" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- 조건 입력 테이블 시작 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">근태구분</td>
					<td class="padding2423">
                        <input id="txtGUN_GBN" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">결재일시</td>
					<td class="padding2423">
                        <input id="txtUPT_YMD" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">결재사유</td>
					<td class="padding2423">
                        <input id="txtREMARK" style="width:100%;text-align:left;">
                    </td>
				</tr>
            </table>
            </td>
	</table>
	<!-- 조건 입력 테이블 끝 -->
</tr>
</table>

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- 조회 상태 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_CHANGE">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>