package Ehr.idt.a.idta030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTA030DAO extends AbstractDAO {
	/**
	 * IDTA030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ������û��Ȳ�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR(CBox p_box) throws CException {

		String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String CEF_SEC_SHR    = JSPUtil.rns(p_box.get("CEF_SEC_SHR")); // ����(����,���,����,�ڵ���)
		String CEF_STS_SHR    = JSPUtil.rns(p_box.get("CEF_STS_SHR")); // ��ȸ����(����,��û,�ݼ�,�߱�,�������)
        String REQ_NO         	= JSPUtil.rns(p_box.get("REQ_NO"));

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
        };

		/** ��ȸ ����(�������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD >= '"+STR_YMD_SHR+"' \n");
			sb.append("AND A.REQ_YMD <= '"+END_YMD_SHR+"' \n");
		} else if (!STR_YMD_SHR.equals("") && END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD >= '"+STR_YMD_SHR+"' \n");
		} else if (STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.REQ_YMD <= '"+END_YMD_SHR+"' \n");
		}

		// ���� ����
		if( !CEF_SEC_SHR.equals("0")
                && !CEF_SEC_SHR.equals("")){
			sb.append("AND A.CEF_SEC = '"+CEF_SEC_SHR+"' \n");
		}
		// ��ȸ����(�������)
		if( !CEF_STS_SHR.equals("0")
                && !CEF_STS_SHR.equals("")){
			sb.append("AND A.CEF_STS = '"+CEF_STS_SHR+"' \n");
		}

        if(!REQ_NO.equals("")) {
            sb.append("AND A.REQ_NO = '"+REQ_NO+"'");
        }

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		prop.add("CEF_STS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CET_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��� ����(HDPS)�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR_01");

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("vusrid"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��� ����(�ּ�)�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���� �߱� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_INS");

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	  		
		
		String YEAR   = JSPUtil.rns(p_box.get("vcurdate")).substring(0,4);

        //System.out.println("SESSION_TODAY   =========================================== " + SESSION_TODAY);	
    	//System.out.println("YEAR"+YEAR);		
		
		String SPL_YEAR = YEAR;
		if( JSPUtil.rns(vo.get("SPL_YMD")).equals("")){
			SPL_YEAR = "";
		}
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				YEAR+"ID",
                YEAR+"ID",// ��û��ȣ(�⵵+�μ��ڵ�+001)
				JSPUtil.rns(vo.get("ENO_NO")),     // ��û�ڻ��
				JSPUtil.rns(vo.get("CEF_SEC")),    // ��û������
				JSPUtil.rns(vo.get("CEF_RSN")),    // �뵵
				JSPUtil.rns(vo.get("CEF_CNT")),    // �ż�
				SPL_YEAR,SPL_YEAR,SPL_YEAR,        // �߱޹�ȣ (�⵵+"-"+0001)
				JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", ""),    // ��û����
				JSPUtil.rns(vo.get("SPL_YMD")).replaceAll("-", ""),    // �߱�����
				JSPUtil.rns(vo.get("CEF_STS")),    // �߱�
				JSPUtil.rns(vo.get("PRT_YMD")).replaceAll("-", ""),    // ÷�ι��������
				JSPUtil.rns(vo.get("REMARK")),     // ���
				JSPUtil.rns(p_box.get("vusrid")),
				// ���ʵ����
				JSPUtil.rns(p_box.get("vusrid")),
				// ����������
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("CITY"))
			};

			/** INSERT�޼ҵ� ȣ��  **/
			insertProcess(sql, bind);
		}

	/**
	 * ������û ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_UPT");

		String SPL_YEAR = JSPUtil.rns(p_box.get("vcurdate")).substring(0,4);

		if( JSPUtil.rns(vo.get("SPL_YMD")).equals("")){
			SPL_YEAR = "";
		}
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CEF_SEC")),    // ��û������
				JSPUtil.rns(vo.get("CEF_RSN")),    // �뵵
				JSPUtil.rns(vo.get("CEF_CNT")),    // �ż�
				JSPUtil.rns(vo.get("SPL_YMD")).replaceAll("-", ""),    // �߱�����
				SPL_YEAR,SPL_YEAR,SPL_YEAR,        // �߱޹�ȣ (�⵵+"-"+0001)    // �߱�����
				JSPUtil.rns(vo.get("CEF_STS")),    // �߱�
				JSPUtil.rns(vo.get("PRT_YMD")).replaceAll("-", ""),    // ÷�ι��������
				JSPUtil.rns(vo.get("REMARK")),     // ���
				JSPUtil.rns(p_box.get("vusrid")),

				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("CITY")),

				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

    /**
     * ���� ������ڸ� �����Ѵ�.
     * @param p_box
     * @throws CException
     */
	public void IDTA030_UPT_PRT(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTA030_UPT_PRT");
	    
	    //System.out.println("--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>");
	    
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("vusrid")),
	            JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}

	/**
	 * ������û ������ �����ϴ�  DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void IDTA030_DEL(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA030_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
}
