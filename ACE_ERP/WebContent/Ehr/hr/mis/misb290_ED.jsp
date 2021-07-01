<!--
***********************************************************************
* @source      : misz000_ED.jsp
* @description : 부서별 직위별 인원 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/21     이승욱        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
  elsoft.extquery.*"
%>
<%@page import = "com.shift.gef.support.vo.*"%>
<%@page import = "com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import = "com.shift.gef.support.vo.DynamicValueObject"%>
<%@page import = "com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import = "com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import = "com.shift.gef.enterprise.dao.AbstractDAO"%>

<%
    String STR_YMD = request.getParameter("STR_YMD");
    String sql     = "";
	sql = XmlSqlUtils.getSQL("mis", "MISB290_SHR");

    /** 외부 XML에서 SQL을 읽어 온다 **/

    Object[] bind = new Object[] {
            STR_YMD,
            STR_YMD,
    };
    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
	String     colStr  =   "DPT_NM,A_TAG,HEAD_NM,HSORT_NO,ASORT_NO,DSORT_NO,TOT_CNT,OCCA_CNT,C1,D1,E1,S2,S3,S4M,S4F,S5M,S5F,Z_CNTM,Z_CNTF";

       String[] values = colStr.split(",");
       for( int x = 0; x < values.length; x++ ){
           hnwExtQuery.AddField(values[x]);
       }
    hnwExtQuery.SendField(response);

       if (voList.size() > 0)
       {
           for (int i=0; i<voList.size(); i++)
           {
               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

               for( int x = 0; x < values.length; x++ ){
                   hnwExtQuery.AddData(vo.getString(values[x]));
               }
               hnwExtQuery.SendData(response);
           }
       }
       else
       {
           // hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
           for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
           }
           hnwExtQuery.SendData(response);

       }
           hnwExtQuery.EndData(response);

%>
