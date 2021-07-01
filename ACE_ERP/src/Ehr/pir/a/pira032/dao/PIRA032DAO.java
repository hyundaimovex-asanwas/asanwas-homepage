package Ehr.pir.a.pira032.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA032DAO extends AbstractDAO {
		/** 
		 * PIRA032DAO ������
		 * @param p_conn	Connection
		 * @param p_tr		TrBox
		 * @throws CException
		 */
		public PIRA032DAO(String p_dsId, TrBox p_tr) throws CException {
			
			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
			
		}
		
		/**
		 * ������� SELECT�� �����ϴ� DAO �޼ҵ�
		 * @param p_box
		 * @throws CException
		 */
		public void PIRA032_SHR(CBox p_box) throws CException {
			
			/** �ܺ� XML���� ������� ������ ��ȸ SQL ���� **/
			String sql = null;
			
			// ���Ի��
			if (p_box.get("GUBUN").equals("1")) {
				sql = XmlSqlUtils.getSQL("pir", "PIRA032_SHR");
			}
			// �İ߻��
			else if (p_box.get("GUBUN").equals("2")) {
				sql = XmlSqlUtils.getSQL("pir", "PIRA032_SHR_02");
			}
			
			/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
			Object[] bind = new Object[] {
			};
			
			/** FirstRow�޼ҵ� ȣ�� **/
			this.selectProcessFirstRow(sql, bind, prop);
		}
}
