package Ehr.idt.c.idtc010.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC010DAO extends AbstractDAO {
	
	/**
	 * IDTC010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC010_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC010_SHR");

        String STR_YMD      = JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "");
        String END_YMD      = JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "");
        String CEF_STS      = JSPUtil.rns(p_box.getString("CEF_STS"));






        
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {

        };
        

        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	
	
    /**
     * �ְ��������� ������ �����ϴ� DAO �޼ҵ�.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC010_INS_TEMP(GauceValueObject vo, CBox p_box) throws CException {
		
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC010_INS_TEMP");

        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
               ,JSPUtil.rns(vo.get("ENO_NO"))
        };

        this.insertProcess(sql, bind);
        
	}
	
	

    /**
     * ������ �����ϴ� DAO �޼ҵ�.
     * @param p_box
     * @throws CException
     */
	public void IDTC010_DEL_TEMP(CBox p_box) throws CException {
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTC010_DEL_TEMP");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("vusrid"))
	    };

	    this.deleteProcess(sql, bind);
	}

}