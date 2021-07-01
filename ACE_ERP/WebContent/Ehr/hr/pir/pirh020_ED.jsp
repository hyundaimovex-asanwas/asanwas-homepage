<!--
***********************************************************************
* @source      : pirh020_ED.jsp
* @description : ���޺�,����б��� �ο���Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
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
    String HIR_YMD_SHR = request.getParameter("HIR_YMD_SHR").replaceAll("-", ""); // ��������
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");// �ٷα���
    String EDGR_CD_SHR = request.getParameter("EDGR_CD_SHR");// �з�
    String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");// ����

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("pir", "PIRH020_SHR");


    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
//    �з±��п� ��� �߰��� �Ʒ��κ� ��ġ
//    Object[] bind = null;
    Object[] bind = new Object[] {
            "","","","","","","",
            "","","","","","",""
        };

    StringBuffer sb = new StringBuffer();

    /** ��ȸ ���ǿ� ���� ó�� **/
    if( EDGR_CD_SHR.equals("") || EDGR_CD_SHR.equals("9")){ // ��ü
    }else if( EDGR_CD_SHR.equals("0") || EDGR_CD_SHR.equals("9")){ // ����� || ��Ÿ
        sb.append("AND EDGR_CD IS NULL \n");
    }else {
        sb.append("AND EDGR_CD = '"+EDGR_CD_SHR+"' \n");
        String EDGR_CD = "";
//  ������� �з±��п� ��� �߰��� ������ �κ�
        if(EDGR_CD_SHR.equals("1")){        EDGR_CD="";            } // �ʵ��б�
        else if(EDGR_CD_SHR.equals("2")){    EDGR_CD="E8";        } // ���б�
        else if(EDGR_CD_SHR.equals("3")){    EDGR_CD="E2";        } // ����б�
        else if(EDGR_CD_SHR.equals("4")){    EDGR_CD="E3";        } // ������
        else if(EDGR_CD_SHR.equals("5")){    EDGR_CD="E4";        } // ���б�
        else if(EDGR_CD_SHR.equals("6")){    EDGR_CD="E5";        } // ���п�(����)
        else if(EDGR_CD_SHR.equals("7")){    EDGR_CD="E5";        } // ���п�(����)
        else if(EDGR_CD_SHR.equals("8")){    EDGR_CD="E5";        } // ���п�(�ڻ�)
        else if(EDGR_CD_SHR.equals("9")){    EDGR_CD="";        }

        bind = new Object[] {
                EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,
                EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD
        };
//  ������� �з±��п� ��� �߰��� ������ �κ�
    }
    if( ! GBN_CD_SHR.equals("0") ){
        if( GBN_CD_SHR.equals("1") ){
            sb.append("AND VI.GBN_CD  = '1' \n"); // ���� ��
        }else{
            sb.append("AND VI.GBN_CD != '1' \n"); // ����(1) �� �ƴ� ���
        }
    }
    if( ! OCC_CD_SHR.equals("0") ){
        sb.append("AND VI.OCC_CD = '"+OCC_CD_SHR+"' \n");
    }
    if( ! HIR_YMD_SHR.equals("") ){
        sb.append("AND TO_CHAR(HIR_YMD,'YYYYMMDD') <= '"+HIR_YMD_SHR+"' \n");
		sb.append("AND (RET_YMD IS NULL OR TO_CHAR(VI.RET_YMD,'YYYYMMDD') > '"+HIR_YMD_SHR+"') \n");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
            sb.toString(),
            sb.toString(),
            sb.toString(),sb.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
    String     colStr  =   "JOB_NM,CNT_TOT,SCH_01,SCH_02,SCH_03,SCH_04,SCH_05,SCH_06,SCH_07,SCH_08,SCH_09,SCH_10,SCH_11,SCH_12,SCH_13,SCH_14,CNT_ETC";
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
        // hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
        for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
        }
        hnwExtQuery.SendData(response);

    }
%>
