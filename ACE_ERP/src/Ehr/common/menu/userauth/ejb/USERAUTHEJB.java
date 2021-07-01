package common.menu.userauth.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.userauth.wrk.USERAUTHWRK;

public class USERAUTHEJB extends EJB {
	public CBox box = null;
    public TrBox trBox = null;
    public USERAUTHEJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		USERAUTHWRK wrk = new USERAUTHWRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (box.get("S_MODE").equals("SHR_00")) {

			//����ڱ���������ȸ
			wrk.USERAUTH_SHR_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {

			//���ѿ� ���� �޴�Ʈ�� ��ȸ(���λ�ý���)
			wrk.USERAUTH_SHR_01(box, trBox);
		}
		
		else if (box.get("S_MODE").equals("SHR_02")) {

			//���ѿ� ���� �޴�Ʈ�� ��ȸ(�濵�����ý���)
			wrk.USERAUTH_SHR_02(box, trBox);
		}	
        
		else if (box.get("S_MODE").equals("SHR_03")) {
		    
		    //����ڰ� ��밡���� ���� �޴��� ������ �´�.
		    wrk.USERAUTH_SHR_03(box, trBox);
		}		
        
		else if (box.get("S_MODE").equals("SHR_04")) {
		    
		    //EIS���� ��� ������ ���� �޴��� ������ �´�.
		    wrk.USERAUTH_SHR_04(box, trBox);
		}
		
		else if (box.get("S_MODE").equals("SHR_05")) {
			
			//sso
			wrk.USERAUTH_SHR_05(box, trBox);
		}		

		return null;
	}

}
