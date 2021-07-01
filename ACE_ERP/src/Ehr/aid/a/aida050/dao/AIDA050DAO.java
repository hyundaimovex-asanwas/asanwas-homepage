package Ehr.aid.a.aida050.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class AIDA050DAO extends AbstractDAO {
	/** 
	 * AIDA050DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
	
	/**
	 * ����������ޱ��� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA050_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("CEF_SEC_SHR"))
        };
		
		prop.add("AID_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * ����������ޱ��� ������ ����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA050_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CEF_SEC")),
                JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("JOB_CD_TO")),
                JSPUtil.rns(vo.get("LSE_YY1")),
                JSPUtil.rns(vo.get("LSE_YY2")),
				JSPUtil.rns(vo.get("AID_AMT")),
				JSPUtil.rns(vo.get("AID_RPT")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
    
	/**
	 * ����������ޱ��� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_UPT(GauceValueObject vo, CBox p_box) throws CException {
	    
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA050_UPT");
	    
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("AID_AMT")),
	            JSPUtil.rns(vo.get("AID_RPT")),
                JSPUtil.rns(vo.get("JOB_CD_TO")),
                JSPUtil.rns(vo.get("LSE_YY2")),
	            JSPUtil.rns(vo.get("REMARK")),
	            JSPUtil.rns(p_box.get("vusrid")),
	            JSPUtil.rns(vo.get("CEF_SEC")),
	            JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("LSE_YY1"))
	    };
	    
	    /** UPDATE�޼ҵ� ȣ��  **/
	    updateProcess(sql, bind);
	}
    
	/**
	 * ����������ޱ��� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA050_DEL(GauceValueObject vo, CBox p_box) throws CException {
	    
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA050_DEL");
	    
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("CEF_SEC")),
                JSPUtil.rns(vo.get("AID_CD")),
                JSPUtil.rns(vo.get("JOB_CD_FROM")),
                JSPUtil.rns(vo.get("LSE_YY1"))
	    };
	    
	    /** UPDATE�޼ҵ� ȣ��  **/
	    deleteProcess(sql, bind);
	}
}
