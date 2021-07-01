package Ehr.vlu.m.vlum020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUM020DAO extends AbstractDAO {

	public VLUM020DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	public void VLUM020_SHR(CBox p_box) throws CException {  

		String sql = XmlSqlUtils.getSQL("vlu", "VLUM020_SHR");


		Object[] bind = new Object[] {

				p_box.get("REG_YM_SHR").replaceAll("-", ""),                        // ������
				//p_box.get("ENO_NO"),                       						// �ǰ����
				//p_box.get("EVA_SEQ"),                       						// ����				
				//p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // ������
				//p_box.get("ENO_NO"),                       						// �ǰ����				
		};
		

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


}
