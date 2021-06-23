<%--
  - 작성자: 이소연
  - 일자: 2006.08  
  - 저작권 표시: IMJ Korea
  - 설명:  일정/견적짜기 사용자 구성 페이지
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%@ page import="kr.co.imjk.reservation.bean.Schedule_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ScheduleInfo"%>
<%@ page import="java.util.Calendar" %> 
<%
  //----상단, 좌측 Flash 변수   START
  String McNum = "2";
  String sub = "3";
  String pageNum = "4";
  String subNum = "0";
  //----상단, 좌측 Flash 변수   END
  
  //---- Calendar 형 날짜 START
  java.util.Calendar c = java.util.Calendar.getInstance();
  String now_y  = String.valueOf(c.get(java.util.Calendar.YEAR));
  String now_m = String.valueOf(c.get(java.util.Calendar.MONTH)+1);
  String now_d = String.valueOf(c.get(java.util.Calendar.DAY_OF_MONTH));  
  //---- Calendar 형 날짜 END

  //-- DB연결 객체
  ScheduleInfo dao = new ScheduleInfo();
  Schedule_bean hotel_record[] = dao.getHotelList();
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_green.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/formStr.js"></script>
<script language="JavaScript">
<!--
	function gochange_1(){
              menuNum	= document.forms.pro_kind.selectedIndex;
              boardIdLen	= document.forms.pro_detail_kind.length;
              kind     = document.forms.pro_kind[menuNum].value;
              
              boardName = new Array();
              boardName[0] = "상세상품선택";
              
              boardId = new Array();
              boardId[0] = "-1";
              boardId[1] = "-1";
      
              if(menuNum == 0) {
              	for ( i=boardIdLen -2; i >= 0; i-- ) {
              		document.forms.pro_detail_kind.options[i] = null;
              	}
              	document.forms.pro_detail_kind.options[0] = new Option("상세상품선택", "-1");   
              	document.forms.pro_detail_kind.options[1] = new Option("상세상품선택", "-1");   
              	return;
              }
              
              var cnt = 0;
              
               if(kind  == "1" ) {
               	boardName[0] = '1박2일[8시]';
               	boardId[0] = '1';
               	boardName[1] = '1박2일[11시]';
               	boardId[1] = '2';
               	boardName[2] = '2박3일';
               	boardId[2] = '3';
               	boardName[3] = '당일관광';
               	boardId[3] = '4';
                }
               if(kind  == "2" ) {
               	boardName[0] = '기업연수/워크샵';
               	boardId[0] = '5';
               	boardName[1] = '북측체험관광';
               	boardId[1] = '6';
               	boardName[2] = '산악/등산관광';
               	boardId[2] = '7';
               	boardName[3] = '수학여행/MT';
               	boardId[3] = '8';
               	boardName[4] = '온천관광';
               	boardId[4] = '9';
               	boardName[5] = '효도관광';
               	boardId[5] = '10';
                }
              
              	tot = boardName.length;
              	for ( i = boardIdLen - 2; i >= 0; i-- ) {
              	  document.forms.pro_detail_kind.options[i] = null;
              	}
                     document.forms.pro_detail_kind.options[0] = new Option("상세상품선택", "-1");  
              	for( i = 1; i <= tot; i++ ) {
              	  document.forms.pro_detail_kind.options[i] = new Option(boardName[i-1], boardId[i-1]);
              	}
	
}


var today = new Date();
var year = today.getYear();
var month = today.getMonth()+1;
var day = today.getDate();
var tyear = new String(year);
var tmonth = new String(month);
tmonth = tmonth.length==1?"0"+tmonth:tmonth;
var tday = new String(day);
tday = tday.length==1?"0"+tday:tday;
var tdate = tyear+tmonth+tday;

function initDate()
{
            var f = document.forms;
            var temp = "";
            
            for(i=1;i<=12;i++)
            {
                temp = new String(i);
                temp = temp.length==1?"0"+temp:temp;
                f.date_month.options[i] = new Option(i,temp);
            }
            
}

function ChangeMonth()
{
                var f = document.forms;
                
                if(f.date_year.value == ""){
                   alert("년도를 선택해 주십시요.");
                   f.date_month.selectedIndex=0;
                   return;
                }
                
                var cYear = f.date_year.options[f.date_year.selectedIndex].value;
                var cMonth = f.date_month.options[f.date_month.selectedIndex].text;
                var lastDate=new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 
                
                if((cYear%4==0 && cYear%100!= 0)|| cYear%400 == 0)//윤년이면
                    lastDate[1] = 29;
                
                for(i=f.date_day.options.length-1;i>=1;i--)
                    f.date_day.options[i] = null;
                    
                for(i=1;i<=lastDate[new Number(cMonth)-1];i++)
                {
                    temp = new String(i);    
                    temp = temp.length==1?"0"+temp:temp;
                    f.date_day.options[i] = new Option(i,temp);
                }
}


	function gochange_2(val){
				alert(val);
                var obj = event.srcElement;
            	while(obj.tagName.toLowerCase()!="table")
            	{
            	    obj = obj.parentElement;
            	}
            	//obj = obj.getElementsByTagName("TBODY")[0];
                //alert(obj.innerHTML);   
                //alert(obj.rows.length);
                for(i = obj.rows.length-1;i>2;i--)
                {
                    //alert(i+ " : " + obj.rows(i).rowIndex);
                    obj.deleteRow(obj.rows(i).rowIndex);
                }
                     
		menuNum		= document.forms.hotel_kind.selectedIndex;
		boardIdLen	= document.forms.room_kind.length;
		hotel_kind         = document.forms.hotel_kind[menuNum].value;
		
		boardName = new Array();
		boardName[0] = "객실선택";

		boardId = new Array();
		boardId[0] = "-1";
		boardId[1] = "-1";

		if(menuNum == 0) {
			for ( i=boardIdLen -2; i >= 0; i-- ) {
			  document.forms.room_kind.options[i] = null;
			}
			document.forms.room_kind.options[0] = new Option("객실선택", "-1");   
			document.forms.room_kind.options[1] = new Option("객실선택", "-1");   
			return;
		}
    	          var cnt = 0;
                    <%
                     Schedule_bean room_record[] = dao.getRoomList();
                     for(int r=0;r< room_record.length; r++){
                         Schedule_bean tbean   = room_record[r];
                    %>
                             if(val == '<%=tbean.getUpjang_sid()%>' ) {
                    	              boardName[ cnt ] = '<%=tbean.getRoom_type_nm()%>';    
                    	              boardId[ cnt ] = '<%=tbean.getRoom_type_sid()%>';
                    	              cnt++ ;
                    	        }
                	<%
                      }
                	%>
        
        	           tot = boardName.length;
            	  for ( i = boardIdLen - 2; i >= 0; i-- ) {
            		document.forms.room_kind.options[i] = null;
            	  }
                                   document.forms.room_kind.options[0] = new Option("객실선택", "-1");  
            	  for( i = 1; i <= tot; i++ ) {
            		document.forms.room_kind.options[i] = new Option(boardName[i-1], boardId[i-1]);
            	  }
	}
	
	function hrAdd()
	{
    	    var form=document.forms;
    	    if(form.hotel_kind.value == ""){
    	       alert("숙소를 선택해 주십시요.");
    	       return;
    	    }
    	    
    	    var obj = event.srcElement;
    	    while(obj.tagName.toLowerCase()!="table")
    	    {
    	        obj = obj.parentElement;
    	    }
    	    obj = obj.getElementsByTagName("TBODY")[0];
    	    var tr1 = obj.insertRow();
    	    var td1 = tr1.insertCell();
    	    var td2 = tr1.insertCell();
    	    var td3 = tr1.insertCell();
    	    var td4 = tr1.insertCell();
    	    var td5 = tr1.insertCell();
    	    var td6 = tr1.insertCell();
    	    var td7 = tr1.insertCell();
    	    var td8 = tr1.insertCell();

               var str = "";
               str += "<select   class='fs11' style='width:120px;'>";  
               str += "<option>객실 선택</option>"; 
               <%
                    for(int s=0;s< room_record.length; s++){
                    Schedule_bean tbean2   = room_record[s];
               %>
               if(document.forms.hotel_kind.value == '<%=tbean2.getUpjang_sid()%>' ) {
                            str += "<option value='<%=tbean2.getRoom_type_sid()%>'><%=tbean2.getRoom_type_nm()%></option>"; 
               }
               <%
                   }
               %>
               str += "<select>";
               td4.innerHTML = str;
               
               str = "";
               str += "<select class='fs11' style='width:120px;'>"; 
               str += "<option>인원수 선택</option>";
              <%for(int q=1;q <=3;q++){%>
            		str += "<option value=<%=q%>><%=q%></option>";
               <%}%>
               str += "<select>";    
               td6.innerHTML = str;
               str = "";
               str += "<a href='#'><img src='<%=imageServer%>/tour_img/apply/btn_room_del.gif' vspace='1'></a><!-- 객실삭제 -->";
               td8.innerHTML = str;
        
	}  
	
    function openInfo(val,idx)
    {  
             window.open(val, 'infoView', 'width=520,height=620,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize');
    }
 
-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                     <%@ include file="../../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->
		<!-- / center area  -->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
			<%@ include file="../../include/reservation/tour_reservation_left.jsp" %>
			<!--  left menu flash -->		
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app06.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">일정/견적짜기</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name="forms" method='post'>
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/apply/img_top_schedule01.jpg"></td></tr>
				<tr>
					<td valign="top">					
						<table style="background:url(<%=imageServer%>/tour_img/apply/img_top_schedule02.gif) no-repeat;background-color:#00FFFF"width="690" height="161" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td valign="top">
								<table cellpadding="0" cellspacing="0" border="0" style="margin:16 0 0 148px;">
								<tr valign="top">
									<td height="24" width="88"><img src="<%=imageServer%>/tour_img/apply/txt_date_choice.gif" vspace="3"></td>
									<td width="100">                    									
										<select name="date_year" class="fs11" style="width:100px;" onchange="ChangeMonth()">
										    <option>년선택</option>
										    <%for (int y=Integer.parseInt(now_y); y <= Integer.parseInt(now_y)+10; y++){%>
											<option value="<%=y%>"><%=y%></option>
										    <%}%>
										<select>
									</td>
									<td width="10"></td>
									<td width="100">		
										<select name="date_month" class="fs11" style="width:120px;" onchange="ChangeMonth()">
											<option>월선택</option>
										<select>
									</td>
									<td width="10"></td>
									<td colspan="2">
										<select name="date_day" class="fs11" style="width:120px;">
											<option>일선택</option>
										<select>
									</td>
								</tr>
								<tr valign="top">
									<td height="57"><img src="<%=imageServer%>/tour_img/apply/txt_goods_choice.gif" vspace="3"></td>
									<td>
										<select name="pro_kind" class="fs11" style="width:100px;" onchange="gochange_1()">
											<option value="0">상품선택</option>
											<option value="1">기본상품</option>
											<option value="2">맞춤상품</option>
										<select>
									</td>
									<td width="10"></td>
									<td colspan="4">
										<select name="pro_detail_kind" class="fs11" style="width:120px;" onchange="FormValue(document.forms.pro_detail_kind.options[document.forms.pro_detail_kind.selectedIndex].value)">
											<option selected >상세상품선택</option>
										<select>
									</td>
								</tr>
								<tr valign="top">
									<td height="25" width="88"><img src="<%=imageServer%>/tour_img/apply/txt_room_choice.gif" vspace="3"></td>
									<td width="100">
										<select name="hotel_kind" class="fs11" style="width:100px;" onchange="gochange_2(document.forms.hotel_kind.value)">
                                            <option>숙소 선택</option>
                                          <%
                                            for(int h=0;h< hotel_record.length; h++){
                                             Schedule_bean tbean   = hotel_record[h];
                                          %>
											<option value="<%=tbean.getUpjang_sid()%>"><%=tbean.getUpjang_nm()%></option>
										  <%}%>
										<select>
									</td>
									<td width="10"></td>
									<td width="120">
										<select name="room_kind" class="fs11" style="width:120px;">
											<option>객실 선택</option>
										<select>
									</td>
									<td width="10"></td>
									<td width="120">
										<select name="cust_num" class="fs11" style="width:120px;">
										    <option>인원수 선택</option>
										  <%for(int p=1;p<=3;p++){%>
											<option value="<%=p%>"><%=p%></option>
                                                                                                             <%}%>
										<select>
									</td>
									<td width="10"></td>
									<td><a href="javascript:;" onclick="hrAdd()"><img src="<%=imageServer%>/tour_img/apply/btn_room_add.gif" vspace="1"></a><!-- 객실추가 --></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td style="padding:7 4 0 0px;" align="right"><img src="<%=imageServer%>/tour_img/apply/txt_tip_schedule.gif"></td></tr>
				<tr><td height="20"></td></tr>
				<tr>
				 <td>
                                            <div id="sch_add"></div>  
				 </td>
				</tr>
				</table>
</form>				
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--  center area / -->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
<script language="javascript">
    FormValue();
    initDate();
</script>

</body>
</html>