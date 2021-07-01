package Ehr.aid.a.aida010.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class AIDA010DAO extends AbstractDAO {
	/**
	 * AIDA010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	/**
     * ���� �̹� ��� �ִ��� ���θ� ������
     * @param vo
     * @return
     * @throws CException
	 */
	public int AIDA010_CHK(GauceValueObject vo) throws CException {
		
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
        return rstVO.get(0).getInt("CNT");
	}

    /**
     * ������ ������ �̹� ��� �ִ��� ���θ� ������
     * @param vo
     * @return
     * @throws CException
     */
	public int AIDA010_CHK_01(GauceValueObject vo) throws CException {
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK_01");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("ORD_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
	    return rstVO.get(0).getInt("CNT");
	}

    /**
     * ������� ������ 2�� �� �����ߴ��� ���� �ľ��Ѵ�
     * @param vo
     * @return
     * @throws CException
     */
	public int AIDA010_CHK_02(GauceValueObject vo) throws CException {
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK_02");

	    System.out.print(vo);
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
	    return rstVO.get(0).getInt("CNT");
	}
	/**
	 * ������� ��û�� ������ ��ȸ�� ���� DAO�޼ҵ� -> ����
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
               ,JSPUtil.rns(p_box.get("ENO_NO_SHR"))
               ,JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "")
               ,JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "")
               ,JSPUtil.rns(p_box.get("AID_STS_SHR"))
        };

		prop.add("HLP1_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HLP2_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * ��� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		        JSPUtil.rns(p_box.get("ENO_NO"))
		};

        //prop.add("LSE_YY", ColumnProp.COLUMN_TYPE_STRING, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("LSE_MM", ColumnProp.COLUMN_TYPE_STRING, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("LSE_YY", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		//prop.add("LSE_MM", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		
		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * ���� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("vusrid"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��û�ڿ� �ش��ϴ� ���ޱݾ��� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_03(CBox p_box) throws CException {
		
		// ��û����(REQ_NO)�� �������� �ټ� ����� ���ϴ� �޼���
		String yyyymmdd = JSPUtil.Gunsok_Date( JSPUtil.rns(p_box.get("HIR_YMD")).replaceAll("-", ""), JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", "") );

		int year = Integer.parseInt(yyyymmdd.substring(0,4));
		int month = Integer.parseInt(yyyymmdd.substring(5,6));


		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			year+"",
			month+"",
			JSPUtil.rns(p_box.get("AID_CD")),
			year+"",
			JSPUtil.rns(p_box.get("JOB_CD"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * ��û��ȣ(REQ_NO)�� �ش��ϴ� ��û���� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet AIDA010_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * �Է��� ������ ������ ��ȸ �Ѵ�.
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet AIDA010_SHR_05(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_05");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("REQ_NO"))
	    };

        prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        
	    return this.selectProcess(sql, bind, prop);
	    
	}
	/**
	 * ��� ������ ��ȸ�� ���� DAO�޼ҵ� =  ��û���(A2�߽�) 2009.12.24 By KHS
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_06(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                ,JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                ,JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "")
                ,JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "")
                ,JSPUtil.rns(p_box.get("AID_STS_SHR"))
         };

 		prop.add("HLP1_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
 		prop.add("HLP2_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);

 		this.selectProcessFirstRow(sql, bind, prop);
 	}
	/**
	 * �ټӳ���� ��ȸ�� ��
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_LSE(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_LSE");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "")

	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_PRINT0(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT0");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_PRINT(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * ������� ��û���� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("REQ_NO")),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("OCC_CD")),
			JSPUtil.rns(vo.get("DPT_CD")),
			JSPUtil.rns(vo.get("JOB_CD")),
			JSPUtil.rns(vo.get("LSE_YY")),
			JSPUtil.rns(vo.get("LSE_MM")),
			JSPUtil.rns(vo.get("ABA_CD")),
			JSPUtil.rns(vo.get("ACC_NO")),
			JSPUtil.rns(vo.get("REC_NM")),
			JSPUtil.rns(vo.get("AID_CD")),
			JSPUtil.rns(vo.get("AID_NM")),
			JSPUtil.rns(vo.get("AID_YMD").replaceAll("-", "")),
			JSPUtil.rns(vo.get("AID_RPT")),
			JSPUtil.rns(vo.get("REQ_YMD").replaceAll("-", "")),
			JSPUtil.rns(vo.get("HLP1_AMT")),
			JSPUtil.rns(vo.get("HLP2_AMT")),
			JSPUtil.rns(vo.get("AID_CET")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(vo.get("FILE_KEY"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ������� ��û���� �����ϰ�, ���������� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_INS_01(GauceValueObject vo, CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO"))
			   ,JSPUtil.rns(vo.get("ENO_NO"))
			   ,JSPUtil.rns(vo.get("ENO_NM"))
			   ,JSPUtil.rns(vo.get("DPT_CD"))
			   ,JSPUtil.rns(vo.get("JOB_CD"))
			   ,JSPUtil.rns(vo.get("AUTHO_CD"))
               ,JSPUtil.rns(vo.get("APP_YN"))
               ,JSPUtil.rns(vo.get("ARR_TIME"))
			   ,JSPUtil.rns(vo.get("ENO_NO"))
			   ,JSPUtil.rns(p_box.get("vusrid"))
			   ,JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ������� ��û���� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ABA_CD")),
				JSPUtil.rns(vo.get("ACC_NO")),
				JSPUtil.rns(vo.get("REC_NM")),
				JSPUtil.rns(vo.get("AID_CD")),
				JSPUtil.rns(vo.get("AID_NM")),
				JSPUtil.rns(vo.get("AID_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("REQ_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("HLP1_AMT")),
				JSPUtil.rns(vo.get("HLP2_AMT")),
				JSPUtil.rns(vo.get("SPL_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("AID_CET")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("FILE_KEY")),
				JSPUtil.rns(vo.get("REQ_NO")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

    /**
     * ������� ������ ���� �Ѵ�.
     * @param vo
     * @param p_box
     * @throws CException
     */
	public void AIDA010_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_01");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("AID_STS"))
               ,JSPUtil.rns(vo.get("AID_STS"))
               ,JSPUtil.rns(vo.get("RET_RSN"))
               ,JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}
    /**
     * ������� ������ ���� �Ѵ�. 2�� �� ���� �Ϸ� OK
     * @param vo
     * @param p_box
     * @throws CException
     */
	public void AIDA010_UPT_OK(GauceValueObject vo, CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_OK");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}

	/**
     * ���������� �����Ѵ�.
     * @param vo
     * @param p_box
     * @param autho_cd
     * @throws CException
	 */
	public void AIDA010_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_02");
	    

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("APP_YN"))
               ,JSPUtil.rns(p_box.get("vusrid"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(p_box.get("vusrid"))
	    };

	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}

	/**
     * 2�� ������ �̰��� ���·�  ���� �����Ѵ�.
     * @param vo
     * @param p_box
     * @param autho_cd
     * @throws CException
	 */
	public void AIDA010_UPT_02_NEXT(GauceValueObject vo, CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_02_NEXT");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(p_box.get("vusrid"))
	    };

	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}
	/**
	 * ������� ��û���� �����ϴ�  DAO�޼ҵ�.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void AIDA010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
     * ����� ������ ������ �����Ѵ�.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void AIDA010_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_DEL_01");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("ORD_NO"))
	    };

	    /** DELETE�޼ҵ� ȣ��  **/
	    deleteProcess(sql, bind);
	}

	/**
     * ������� ��û�ǿ� ���� ��ȿ�� ����
     * @param p_box
     * @param vo
     * @return - ��� �޼���
     * @throws CException
	 */
    public String PROC_CHK(CBox p_box, GauceValueObject vo) throws CException {

        /** ������� ��û�� **/
        String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_CHK(?, ?, ?, ?, ?, ?, ?, ?) }";

        /*
        System.out.println(JSPUtil.rns(vo.get("ENO_NO")));
        System.out.println(JSPUtil.rns(vo.get("AID_CD")));
        System.out.println(JSPUtil.rns(vo.get("AID_CET")));
        System.out.println(JSPUtil.rns(vo.get("AID_NM")));
        System.out.println(JSPUtil.rns(vo.get("AID_YMD")));
        System.out.println(JSPUtil.rns(vo.get("REQ_YMD")));
        System.out.println(JSPUtil.rns(vo.get("ACC_NO")));
         */

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",         JSPUtil.rns(vo.get("ENO_NO"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_CD"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_CET"))      },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_NM"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_YMD")).replaceAll("-", "")      },
                {"IN",      "",         JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", "")      },
                {"IN",      "",         JSPUtil.rns(vo.get("ACC_NO"))       },

                {"OUT",     "RESULT_MSG"    ,""     ,String.valueOf(OracleTypes.VARCHAR)} //�۾��Ϸ�޼���
        };

        System.out.println(  JSPUtil.rns(vo.get("ENO_NO"))                      +"\n"
                +JSPUtil.rns(vo.get("AID_CD"))                      +"\n"
                +JSPUtil.rns(vo.get("AID_CET"))                     +"\n"
                +JSPUtil.rns(vo.get("AID_YMD")).replaceAll("-", "") +"\n"
                +JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", "") +"\n"
                +JSPUtil.rns(vo.get("ACC_NO"))                      +"\n"
               );

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        CBox box = (CBox)this.executeProcedure(sql, bind, null);
        return box.getString("RESULT_MSG");
    }


	/**
	 * ������� ��ǥ ó��
	 * @param p_box
	 * @throws CException
	 */
	public void PROC_D(CBox p_box) throws CException {

	    /** ������� ���� ó��  **/
	    String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_D(?, ?) }";

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REQ_NO"))        },
	            {"IN",      "",         JSPUtil.rns(p_box.get("vusrid")) }
	    };

	    /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
	    this.executeProcedure(sql, bind, null);
	}

    /**
     * ������� ���� ó��
     * @param p_box
     * @throws CException
     */
    public void PROC_E(CBox p_box) throws CException {

        /** ������� ���� ó��  **/
        String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_E(?, ?, ?) }";

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",         JSPUtil.rns(p_box.get("REQ_NO"))                        },
                {"IN",      "",         JSPUtil.rns(p_box.get("SPL_YMD")).replaceAll("-", "")   },
                {"IN",      "",         JSPUtil.rns(p_box.get("vusrid"))                 }
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        this.executeProcedure(sql, bind, null);
    }

    /// ���� ��ǥ �߻��� ���Ѱ͵�.....
	/**
	 * ��ǥ �߻��� �ʿ��� �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet AIDA010_PRC_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_PRC_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ���翡 �ʿ��� �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet AIDA010_PRC_SHR_02(GauceDataSet ds) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_03");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(GauceUtils.nameValue(ds, 1, 	"FILE_KEY"))
        };

		return this.selectProcess(sql, bind, prop);
	}

	/**
     * �����ݽ�ûTable�� �����ݽ�û���� Update DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void AIDA010_PRC_UPT_01(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_PRC_UPT_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("WRK_NO1"),
				p_box.get("REQ_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}



	/**
     * ��ǥ�߻��ÿ� ������� html
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void AIDA010_PRC_MAKE_HTML(CBox p_box,GauceDataSet ds, GauceDataSet dsDecision, GauceDataSet dsFile) throws CException {

		String REQ_NO		= GauceUtils.nameValue(ds, 1, "REQ_NO");
		String DPT_NM       = GauceUtils.nameValue(ds, 1, "DPT_NM");
		String JOB_NM	    = GauceUtils.nameValue(ds, 1, "JOB_NM");
		String ENO_NO   	= GauceUtils.nameValue(ds, 1, "ENO_NO");
		String NAM_KOR		= GauceUtils.nameValue(ds, 1, "NAM_KOR");
		String CET_NO		= GauceUtils.nameValue(ds, 1, "CET_NO");
		String HIR_YMD		= GauceUtils.nameValue(ds, 1, "HIR_YMD");
		String RET_YMD		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "RET_YMD"));
		String LSE_YY		= GauceUtils.nameValue(ds, 1, "LSE_YY");
		String LSE_MM		= GauceUtils.nameValue(ds, 1, "LSE_MM");
		String AID_CD_NM	= GauceUtils.nameValue(ds, 1, "AID_CD_NM");
		String AID_CET		= GauceUtils.nameValue(ds, 1, "AID_CET");
		String AID_NM		= GauceUtils.nameValue(ds, 1, "AID_NM");
		String AID_YMD		= GauceUtils.nameValue(ds, 1, "AID_YMD");
		String ABA_NM		= GauceUtils.nameValue(ds, 1, "ABA_NM");
		String REC_NM		= GauceUtils.nameValue(ds, 1, "REC_NM");
		String ACC_NO		= GauceUtils.nameValue(ds, 1, "ACC_NO");
		String REQ_YMD		= GauceUtils.nameValue(ds, 1, "REQ_YMD");
		String HLP1_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "HLP1_AMT").replaceAll(",", "."));
		String HLP2_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "HLP2_AMT").replaceAll(",", "."));
		String SUM_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "COST_AMT").replaceAll(",", "."));
		String SPL_YMD		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "SPL_YMD"));
		String WORK_NO1		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "WORK_NO1"));
		String AID_STS_NM	= GauceUtils.nameValue(ds, 1, "AID_STS_NM");
		String RET_RSN		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "RET_RSN"));
		String FILE_NAME       = GauceUtils.nameValue(ds, 1, "FILE_NAME");

		StringBuffer content = new StringBuffer();
		content.append(" <html>                                                                                       																														");
		content.append(" <head>                                                                                                                                                   ");
		content.append(" 	<title>������ݽ�û����</title>                                                                                                          ");
		content.append(" 	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>                                                                                    ");
		content.append(" 	<link href='/css/style.css' rel='stylesheet' type='text/css'>                                                                                           ");
		content.append(" 	<link href='/css/general.css' rel='stylesheet' type='text/css'>                                                                                         ");
		content.append(" 	<script language=javascript src='/common/common.js'></script>                                                                                                               \n");
		content.append(" 	<script language=javascript src='/common/input.js'></script>                                                                                                                \n");
		content.append(" 	<script language=javascript src='/common/mdi_common.js'></script>                                                                                                           \n");
		content.append(" 	<script language='javascript' src='/common/calendar/calendar.js'></script>                                                                                                  \n");
		content.append("	<SCRIPT LANGUAGE='JavaScript'>											\n");
		content.append("	<!--                                                \n");
		content.append("	function fnc_FileDownload(vFILE_NAME, vFILE_URL){   \n");
		content.append("            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~  \n");
		content.append("            if (vFILE_NAME != '' && vFILE_URL != '') {\n");
		content.append("                cfDownload(vFILE_NAME, vFILE_URL);    \n");
		content.append("            }                                         \n");
		content.append("	}                                                   \n");
		content.append("	//-->                                               \n");
		content.append("	</SCRIPT>                                           \n");
		content.append(" <body leftmargin='20' topmargin='14' rightmargin='20' bottommargin='15' marginwidth='0' marginheight='0' scroll=auto >                                   ");
		content.append(" 	<form name='form1'>                                                                                                                                     ");
		content.append(" 	<table width='800' border='0' cellspacing='0' cellpadding='0'>                                                                                          ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td>                                                                                                                                                  ");
		content.append(" 		<table width='100%' border='0' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>           ");
		content.append(" 		<tr height='50'>                                                                                                                                      ");
		content.append(" 			<td colspan='8'>                                                                                                                                    ");
		content.append(" 				<table width='100%' border='0' cellspacing='0' cellpadding='0'>                                                                                   ");
		content.append(" 				<tr align='center'>                                                                                                                               ");
		content.append(" 					<td>&nbsp;</td>                                                                                                                                 ");
		content.append(" 					<td align='right'>                                                                                                                              ");
		content.append("     					<table border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse'  bordercolor='#999999' align='right'>                   ");
		content.append("         					<tr align='center' height='25'>                                                                                                         ");
		content.append("         						<td rowspan='2' class='creamBold' width='50'>����<br>��Ȳ                                                                             ");
		content.append("                                     &nbsp;                                                                              ");
		content.append("                                 </td>                                                                                                                    ");
		content.append("                                 <td id='txtA1_ENO_NM' width='120'>").append(GauceUtils.nameValue(dsDecision, 1, "JOB_NM")).append(" ").append(GauceUtils.nameValue(dsDecision, 1, "ENO_NM")).append("</td>");
		content.append("                                 <td id='txtA2_ENO_NM' width='120'>").append(GauceUtils.nameValue(dsDecision, 2, "JOB_NM")).append(" ").append(GauceUtils.nameValue(dsDecision, 2, "ENO_NM")).append("</td>");
		content.append("         					</tr>                                                                                                                                   ");
		content.append("         					<tr align='center' height='25'>                                                                                                         ");
		content.append("                                 <td id='txtA1_APP_STS'>").append(GauceUtils.nameValue(dsDecision, 1, "APP_YN_NM")).append("</td>             ");
		content.append("                                 <td id='txtA2_APP_STS'>").append(GauceUtils.nameValue(dsDecision, 2, "APP_YN_NM")).append("</td>             ");
		content.append("         					</tr>                                                                                                                                   ");
		content.append("     					</table>                                                                                                                                    ");
		content.append(" 					</td>                                                                                                                                           ");
		content.append(" 				</tr>                                                                                                                                             ");
		content.append(" 				</table>                                                                                                                                          ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		</table>                                                                                                                                              ");
		content.append(" 		</td>                                                                                                                                                 ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td class='paddingTop8'>                                                                                                                              ");
		content.append(" 		<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>           ");
		content.append(" 			<colgroup>                                                                                                                                          ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='100'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='80'></col>                                                                                                                           ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='*'></col>                                                                                                                             ");
		content.append(" 			</colgroup>                                                                                                                                         ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>��û��ȣ</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(REQ_NO).append("</td>                             ");
		content.append("                                                                                                                                                          ");
		content.append("             <td align='center' class='creamBold'>��&nbsp;&nbsp;��</td>                                                                                   ");
		content.append("             <td class='padding2423'>").append(ENO_NO).append("</td>                                                                                      ");
		content.append("             <td align='center' class='creamBold'>��&nbsp;&nbsp;��</td>                                                                                   ");
		content.append("             <td class='padding2423'>").append(NAM_KOR).append("</td>                                                                                     ");
		content.append(" 			<td align='center' class='creamBold'>����</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(JOB_NM).append("</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>�μ�</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(DPT_NM).append("</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>�ֹι�ȣ</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(CET_NO).append("</td>                             ");
		content.append(" 			<td align='center' class='creamBold'>�Ի���</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>").append(HIR_YMD).append("</td>                            ");
		content.append(" 			<td align='center' class='creamBold'>�����</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>").append(RET_YMD).append("</td>                            ");
		content.append(" 			<td align='center' class='creamBold'>�ټӳ��</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(LSE_YY).append("</td>                              ");
		content.append(" 			<td align='center' class='creamBold'>�ټӿ���</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(LSE_MM).append("</td>                              ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		</table>                                                                                                                                              ");
		content.append(" 		</td>                                                                                                                                                 ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td colspan='8' class='paddingTop8'>                                                                                                                  ");
		content.append("      <img src='/images/specialHr/dotGreen.gif' width='10' height='10' align='absmiddle'> ���������� �߻��ϰ� �� ������� ����, �ֹι�ȣ, �߻�����        ");
		content.append("   </td>                                                                                                                                                  ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td>                                                                                                                                                  ");
		content.append(" 		<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse;' bordercolor='#999999' class='table_cream'>          ");
		content.append(" 			<colgroup>                                                                                                                                          ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='100'></col>                                                                                                                           ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='*'></col>                                                                                                                             ");
		content.append(" 			</colgroup>                                                                                                                                         ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>��û����</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(AID_CD_NM).append("</td>                                                                                                                                             ");
		content.append(" 			<td align='center' class='creamBold'>������ֹι�ȣ</td>                                                                                            ");
		content.append(" 			<td class='padding2423'>").append(AID_CET).append("</td>              ");
		content.append(" 			<td align='center' class='creamBold'>����ڼ���</td>                                                                                                ");
		content.append(" 			<td class='padding2423'>").append(AID_NM).append("</td>                                                                         ");
		content.append(" 			<td align='center' class='creamBold'>�߻�����</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(AID_YMD).append("</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append("             <td align='center' class='creamBold' rowspan='4'>���⼭��<br>÷��</td>                                                                                           \n");
		content.append("             <td class='padding2423' colspan='5'  align='right' valign='top'>                                                                                     \n");
		content.append(" 				<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>	                          \n");
		content.append(" 					<tr >                                                                                                                                                               \n");
		content.append(" 					<th width='30' class='creamBold'>NO</th>                                                                                                                            \n");
		content.append(" 					<th class='creamBold'>���ϸ�</th>                                                                                                                                   \n");
		content.append(" 					</tr>                                                                                                                                                               \n");
		String str = "<tr onClick=\"fnc_FileDownload('";
		String end = "')\"  style='cursor:hand'>";
		for(int i = 1; i <= dsFile.getDataRowCnt(); i ++){
			String fileName = GauceUtils.nameValue(dsFile, i, "FILE_NAME");
			String fileURL  = GauceUtils.nameValue(dsFile, i, "FILE_URL");

			content.append(str).append(fileName).append("', '").append(fileURL).append(end).append("                                                         \n");
			content.append(" 					<td>").append(i).append("</th>                                                                                                                                                          \n");
			content.append(" 					<td>").append(fileName).append("</td>                                                                                                                                                  \n");
			content.append(" 					</tr>                                                                                                                                                               \n");
		}

		content.append(" 				</table>                                                                                                                                                              \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append(" 			<td align='center' class='creamBold'>��û����</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(REQ_YMD).append("</td> ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>������</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 			<table width='100%' border='0' >                                                                                                                    ");
		content.append(" 			<tr>                                                                                                                                                ");
		content.append(" 				<td width='90%'>").append(HLP1_AMT).append("</td>                                                                                                                                             ");
		content.append(" 				<td align='left'>��</td>                                                                                                                          ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>������</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 				<table width='100%' border='0' >                                                                                                                  ");
		content.append(" 				<tr>                                                                                                                                              ");
		content.append(" 					<td width='90%'>").append(HLP2_AMT).append("</td>                                                                                                                                             ");
		content.append(" 				<td align='left'>��</td>                                                                                                                          ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>���ޱݾ�</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 				<table width='100%' border='0' >                                                                                                                  ");
		content.append(" 				<tr>                                                                                                                                              ");
		content.append(" 					<td width='90%'>").append(SUM_AMT).append("</td>                                                                                                                                         ");
		content.append(" 						<td align='left'>��</td>                                                                                                                      ");
		content.append(" 					</tr>                                                                                                                                           ");
		content.append(" 					</table>                                                                                                                                        ");
		content.append(" 				</td>                                                                                                                                             ");
		content.append(" 				<td align='center' class='creamBold'>��������</td>                                                                                                ");
		content.append(" 				<td class='padding2423'>").append(SPL_YMD).append("</td>                                                                                                                                             ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			<tr>                                                                                                                                                ");
		content.append(" 			<td align='center' class='creamBold'>������ȣ</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(WORK_NO1).append("</td>                                       ");
		content.append(" 			<td align='center' class='creamBold'>����</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(AID_STS_NM).append("</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>�ݼۻ���</td>                                                                                                  ");
		content.append(" 				<td class='padding2423' colspan='3'>").append(RET_RSN).append("</td>                         ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 	</table>                                                                                                                                                ");
		content.append(" 	</form>                                                                                                                                                 ");
		content.append(" </body>                                                                                                                                                  ");
		content.append(" </html>                                                                                                                                                  ");

		try{
			FileOutputStream fos = new FileOutputStream(CommUtil.getHtmlFilePath()+FILE_NAME+".html");
			fos.write(content.toString().getBytes());
			fos.close();
		}catch(IOException e){
			e.printStackTrace();
		}

	}


}