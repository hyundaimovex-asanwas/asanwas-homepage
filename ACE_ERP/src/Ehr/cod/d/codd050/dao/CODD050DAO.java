package Ehr.cod.d.codd050.dao;

import Ehr.common.util.JSPUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODD050DAO extends AbstractDAO {

	
	public CODD050DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

	
    /**
     * ��Ȯ�� �޼��� ��Ȳ ��ȸ
     * @param p_box CBox
     * @throws CException
     */
	public void CODD050_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ��Ȯ�� �޼��� ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODD050_SHR");

		Object[] bind = new Object[] {
				p_box.get("ENO_NO_SHR"),
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
	

	/**
     * ��Ȯ�� �޼��� Ȯ��ó�� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void CODD050_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� Ȯ��ó�� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODD050_UPT");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ")),				//�Ϸù�ȣ
				JSPUtil.rns(vo.get("ENO_NO"))			//�����ȣ
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);

	}	
	

}



