/**
 * @author jwpark
 *
 * �ۼ��� ��¥: 2005. 4. 20.
 * ���� ���ε�� �ý��� ���ϸ��� �����ϴ� �Լ�
 */
package com.hmm.asan.common.util;

import java.io.File;
import java.io.IOException;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class AsanFileRenamePolicy  implements FileRenamePolicy {

  	/**
  	 * ���� �ð��� �������� ������ ����
  	 */
	// This method does not need to be synchronized because createNewFile()
	// is atomic and used here to mark when a file name is chosen
	public File rename(File f) {
	  //if (createNewFile(f)) {
	  //return f;
	  //}
	  String name = f.getName();
	  String body = null;
	  String ext = null;

	  int dot = name.lastIndexOf(".");
	  if (dot != -1) {
		body = name.substring(0, dot);
		ext = name.substring(dot);  // includes "."
	  }
	  else {
		body = name;
		ext = "";
	  }

	  int count = 0;
	  while (true) {
		String newName = System.currentTimeMillis()+Math.random() + ext;
		f = new File(f.getParent(), newName);
		if(createNewFile(f)) break;
	  }

	  return f;
	}

	private boolean createNewFile(File f) {
	  try {
		return f.createNewFile();
	  }
	  catch (IOException ignored) {
		return false;
	  }
	}
}
