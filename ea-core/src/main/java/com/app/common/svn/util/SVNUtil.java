package com.app.common.svn.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.tmatesoft.svn.core.SVNCommitInfo;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.SVNProperties;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.io.ISVNEditor;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.io.diff.SVNDeltaGenerator;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.app.common.svn.model.SVN;

@SuppressWarnings("rawtypes")
public class SVNUtil {
	private String svnRoot;
	private String userName;
	private String password;
	private SVNRepository repository;
	private static Map<String, Long> sizeCache = new HashMap<String, Long>();

	/***
	 * 构造方法
	 * 
	 * @param svnRoot
	 *            svn根目录
	 */
	public SVNUtil(String svnRoot) {
		this.svnRoot = svnRoot;
	}

	/***
	 * 构造方法
	 * 
	 * @param svnRoot
	 *            svn根目录
	 * @param userName
	 *            登录用户名
	 * @param password
	 *            登录密码
	 */
	public SVNUtil(String svnRoot, String userName, String password) {
		this.svnRoot = svnRoot;
		this.userName = userName;
		this.password = password;
	}

	/***
	 * 通过不同的协议初始化版本库
	 */
	private static void setupLibrary() {
		// 对于使用http://和https：//
		DAVRepositoryFactory.setup();
		// 对于使用svn：/ /和svn+xxx：/ /
		SVNRepositoryFactoryImpl.setup();
		// 对于使用file://
		FSRepositoryFactory.setup();
	}

	/***
	 * 每次连接库都进行登陆验证 登录验证
	 * 
	 * @return
	 */
	public boolean login() {
		setupLibrary();
		try {
			// 创建库连接
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(this.svnRoot));
			// 身份验证
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(this.userName, this.password);
			// 创建身份验证管理器
			repository.setAuthenticationManager(authManager);
			
			return true;
		} catch (SVNException svne) {
			svne.printStackTrace();
			return false;
		}
	}

	/***
	 * 下面的方法实现查询给定路径下的条目列表功能
	 * 
	 * @param path
	 * @return 查询给定路径下的条目列表
	 * @throws SVNException
	 */
	public List<SVN> listEntries(String path) {
		Collection entries;
		List<SVN> svns = null;
		try {
			entries = repository.getDir(path, -1, null, (Collection) null);
			Iterator iterator = entries.iterator();
			svns = new ArrayList<SVN>();
			while (iterator.hasNext()) {
				SVNDirEntry entry = (SVNDirEntry) iterator.next();

				SVN svn = new SVN();
				svn.setCommitMessage(entry.getCommitMessage());
				svn.setDate(entry.getDate());
				svn.setKind(entry.getKind().toString());
				svn.setName(entry.getName());
				svn.setRepositoryRoot(entry.getRepositoryRoot().toString());
				svn.setRevision(entry.getRevision());
				/*if (entry.getKind() == SVNNodeKind.DIR) {
					getDirSize(svn, "".equals(entry.getName()) ? entry.getName() : path + "/" + entry.getName());
					svn.setSize(svn.getSize());
				} else {
					svn.setSize(entry.getSize());
				}*/
				svn.setUrl(path.equals("") ? "/" + entry.getName() : path + "/" + entry.getName());
				svn.setAuthor(entry.getAuthor());
				svn.setState(svn.getKind() == "file" ? null : "closed");
				svns.add(svn);
			}
		} catch (SVNException e) {
			e.printStackTrace();
		}

		return svns;
	}

	public void getDirSize(SVN svn, String path) throws SVNException {
		Collection entries = repository.getDir(path, -1, null, (Collection) null);
		Iterator iterator = entries.iterator();
		while (iterator.hasNext()) {
			SVNDirEntry entry = (SVNDirEntry) iterator.next();
			if (entry.getKind() == SVNNodeKind.DIR) {
				
				String svnPath = (path.equals("")) ? entry.getName() : path + "/" + entry.getName();
				getDirSize(svn, svnPath);
				
				Long cacheSize = sizeCache.get(svnPath);
				if(cacheSize == null) {
					getDirSize(svn, svnPath);
					sizeCache.put(svnPath, svn.getSize());
				}else{
					System.out.println("else " + svnPath + "," + sizeCache.get(svnPath));
					svn.setSize(sizeCache.get(svnPath));
				}
			} else {
				long sumSize = svn.getSize() + entry.getSize();
				svn.setSize(sumSize);
//				sizeCache.put(path, sumSize);
			}
		}
	}

	public List<SVN> getHistory(String path) {
		return null;
	}

	public void getFile(int i, String path, ByteArrayOutputStream baos) {
		try {
			SVNProperties fileProperties = new SVNProperties();
			SVNNodeKind nodeKind = repository.checkPath(path, -1);

			if (nodeKind == SVNNodeKind.NONE) {
				System.err.println("There is no entry at '" + path + "'.");
			} else if (nodeKind == SVNNodeKind.DIR) {
				System.err.println("The entry at '" + path + "' is a directory while a file was expected.");
			}
			repository.getFile(path, -1, fileProperties, baos);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void commit(String filePath, byte[] contents) {
		long latestRevision;
		try {
			latestRevision = repository.getLatestRevision();
			System.out.println("Repository latest revision (before committing): " + latestRevision);
			ISVNEditor editor = repository.getCommitEditor("directory and file added", null);
			SVNCommitInfo commitInfo = addFile(editor, filePath, contents);
			System.out.println("The directory was added: " + commitInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static SVNCommitInfo addFile(ISVNEditor editor, String filePath, byte[] data) throws SVNException {
		editor.openRoot(-1);
//		editor.addDir(dirPath, null, -1);
		editor.addFile(filePath, null, -1);
		editor.applyTextDelta(filePath, null);
		SVNDeltaGenerator deltaGenerator = new SVNDeltaGenerator();
		String checksum = deltaGenerator.sendDelta(filePath, new ByteArrayInputStream(data), editor, true);

		editor.closeFile(filePath, checksum);
//		editor.closeDir();
//		editor.closeDir();
//		sizeCache.clear();  // remove size cache
		return editor.closeEdit();
	}

	private static SVNCommitInfo modifyFile(ISVNEditor editor, String dirPath, String filePath, byte[] oldData, byte[] newData) throws SVNException {
		editor.openRoot(-1);
		editor.openDir(dirPath, -1);
		editor.openFile(filePath, -1);

		editor.applyTextDelta(filePath, null);

		SVNDeltaGenerator deltaGenerator = new SVNDeltaGenerator();
		String checksum = deltaGenerator.sendDelta(filePath, new ByteArrayInputStream(oldData), 0, new ByteArrayInputStream(newData), editor, true);

		editor.closeFile(filePath, checksum);
		editor.closeDir();
		editor.closeDir();
		return editor.closeEdit();
	}

}
