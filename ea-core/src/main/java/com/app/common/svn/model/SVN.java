package com.app.common.svn.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class SVN {

	private String commitMessage;
	private Date date;
	private String kind;;
	private String name;
	private String repositoryRoot;
	private long revision;
	private long size;
	private String url;
	private String author;
	private String state;
	public String getCommitMessage() {
		return commitMessage;
	}
	public String getDate() {
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
	public String getKind() {
		return kind;
	}
	public String getName() {
		return name;
	}
	public String getRepositoryRoot() {
		return repositoryRoot;
	}
	public long getRevision() {
		return revision;
	}
	public long getSize() {
		return size;
	}
	public String getUrl() {
		return url;
	}
	public String getAuthor() {
		return author;
	}
	public String getState() {
		return state;
	}
	public void setCommitMessage(String commitMessage) {
		this.commitMessage = commitMessage;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setRepositoryRoot(String repositoryRoot) {
		this.repositoryRoot = repositoryRoot;
	}
	public void setRevision(long revision) {
		this.revision = revision;
	}
	public void setSize(long size) {
		this.size = size;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "SVN [commitMessage=" + commitMessage + ", date=" + date + ", kind=" + kind + ", name=" + name + ", repositoryRoot=" + repositoryRoot + ", revision=" + revision + ", size=" + size
				+ ", url=" + url + ", author=" + author + ", state=" + state + "]";
	}





}
