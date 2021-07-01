package Ehr.idt.c.idtc080.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC080DAO extends AbstractDAO {
	
	/**
	 * IDTC080DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC080DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC080_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR");

		
		/** ��ȸ ����(����1)�� ���� ó�� #1  ����**/
		StringBuffer sb1 = new StringBuffer();

		if (p_box.get("ENO_NO").equals("")) {

		}else {
			
		}		
		
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {

				sb1.toString(),
        		
        };
        

        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

                //JSPUtil.rns(p_box.get("PIS_YY"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	

	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC080_SHR_DTL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR_DTL");

		int WEEK_NO2 = Integer.parseInt(p_box.get("WEEK_NO")) + 1 ;	
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("WEEK_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
				WEEK_NO2,				
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	


	
	
	public void IDTC080_SHR_ALL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR_ALL");



		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

            JSPUtil.rns(p_box.get("ENO_NO"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	

}