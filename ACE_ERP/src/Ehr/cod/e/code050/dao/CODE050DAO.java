package Ehr.cod.e.code050.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODE050DAO extends AbstractDAO {
	/**
	 * PIRA090DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE050DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE050_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE050_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
							p_box.get("ENO_NO")	    // �������
		};

		//prop.add("BIR_TAG", ColumnProp.COLUMN_TYPE_STRING , 4, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



          /**
          * ���μҵ漼����û
          * @param p_box CBox
          * @throws CException
          */
	    public void CODE050_UPT(CBox p_box, GauceValueObject vo) throws CException {

		     /** �ܺ� XML���� SQL�� �о� �´� **/
		     String sql = XmlSqlUtils.getSQL("cod", "CODE050_UPT");
		     
		     /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
             Object[] bind = new Object[] {
            	    	p_box.get("LUN_CHK"),    //�ҵ漼���ڵ�
						p_box.get("ENO_NO")   	 //�����ȣ
					   
	           	};
		      /** UPDATE�޼ҵ� ȣ��  **/
		      updateProcess(sql, bind);
		      
	    }

}
