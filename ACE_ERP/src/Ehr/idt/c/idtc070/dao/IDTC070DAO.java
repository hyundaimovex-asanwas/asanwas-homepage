package Ehr.idt.c.idtc070.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC070DAO extends AbstractDAO {
	
	/**
	 * IDTC070DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC070_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC070_SHR");

		
		/** ��ȸ ����(����1)�� ���� ó�� #1  ����**/
		StringBuffer sb1 = new StringBuffer();

		if (p_box.get("ENO_NO").equals("")) {

			sb1.append("AND 1 = 1 \n");
			
		}else {
			
			sb1.append(" AND B.DPT_CD  = ( SELECT DPT_CD FROM ASNHR.T_CM_PERSON WHERE ENO_NO = '"+p_box.get("ENO_NO")+"')");

		}		
		
		
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {

				sb1.toString(),
        		
        };
        

        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("PIS_YMD"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC070_SHR_DTL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC070_SHR_DTL");

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
	public void IDTC070_INS(GauceValueObject vo, CBox p_box) throws CException {
		
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC070_INS");

        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		 JSPUtil.rns(vo.get("FEED_BACK"))
                ,JSPUtil.rns(p_box.get("vusrid"))        		
        		,JSPUtil.rns(vo.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("WEEK_NO"))
                ,JSPUtil.rns(vo.get("PLAN_EXE"))    
        };

        this.insertProcess(sql, bind);
        
	}
	
	

    /**
     * ������ �����ϴ� DAO �޼ҵ�.
     * @param p_box
     * @throws CException
     */
	public void IDTC070_DEL_TEMP(CBox p_box) throws CException {
	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTC070_DEL_TEMP");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("vusrid"))
	    };

	    this.deleteProcess(sql, bind);
	}

}