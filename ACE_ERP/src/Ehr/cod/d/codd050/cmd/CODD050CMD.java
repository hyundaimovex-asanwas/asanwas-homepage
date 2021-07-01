package Ehr.cod.d.codd050.cmd;

import Ehr.cod.d.codd050.wrk.CODD050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODD050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

        /** WRK Class ��ü ���� * */
		CODD050WRK wrk = new CODD050WRK();

        /** ��Ȯ�� �޼��� ��ȸ�� ���� WRK Class �޼ҵ� ȣ�� * */
        if(p_box.get("S_MODE").equals("SHR")){

            wrk.CODD050_SHR(p_box, p_tr);		

		} else if(p_box.get("S_MODE").equals("SAV"))

            wrk.CODD050_SAV(p_box, p_tr);	
		}

}
