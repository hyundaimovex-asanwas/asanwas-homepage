<!--
***********************************************************************
* @source      : sava020.jsp										  *
* @description : 저축금관리대장 PAGE 	
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    String DED_YM_SHR = request.getParameter("DED_YM_SHR").replaceAll("-", "");
    String OCC_CD_SHR = request.getParameter("OCC_CD_SHR");
    String DPT_CD_SHR = request.getParameter("DPT_CD_SHR");
    String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");
    String BNK_CD_SHR = request.getParameter("BNK_CD_SHR");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("sav", "SAVA020_SHR");

    /** 조회 조건에 따른 처리 **/
    StringBuffer sb = new StringBuffer();
    
    if ( !DED_YM_SHR.equals("") ) {
        sb.append("A.DED_YM = '"+DED_YM_SHR+"' \n");
    }else{
        sb.append("1=1 \n");
    }
    if( ! OCC_CD_SHR.equals("0") ){
        sb.append("AND B.OCC_CD = '"+OCC_CD_SHR+"' \n");
    }
    if( ! DPT_CD_SHR.equals("") ){
        sb.append("AND B.DPT_CD = '"+DPT_CD_SHR+"' \n");
    }
    if( ! JOB_CD_SHR.equals("") ){
        sb.append("AND B.JOB_CD = '"+JOB_CD_SHR+"' \n");
    }
    if( ! BNK_CD_SHR.equals("") ){
        sb.append("AND A.BNK_CD = '"+BNK_CD_SHR+"' \n");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb.toString(),
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("은행명");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("불입횟수");
    hnwExtQuery.AddField("월불입액");
    hnwExtQuery.AddField("불입누계");
    hnwExtQuery.AddField("계약일");
    hnwExtQuery.AddField("만기일");

    hnwExtQuery.AddField("계좌번호");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("BNK_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("PIN_CNT"));
            hnwExtQuery.AddData(vo.getString("PYM_AMT"));
            hnwExtQuery.AddData(vo.getString("SUM_SAV"));
            hnwExtQuery.AddData(vo.getString("CON_YMD"));
            hnwExtQuery.AddData(vo.getString("DUE_YMD"));

            hnwExtQuery.AddData(vo.getString("ACC_NO"));
           
            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>