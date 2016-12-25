/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Entity - 消息
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_message")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_message_sequence")
public class Message extends BaseEntity {

	private static final long serialVersionUID = -5035343536762850722L;

	/** 标题 */
	private String title;

	/** 内容 */
	private String content;

	/** ip */
	private String ip;

	/** 是否为草稿 */
	private Boolean isDraft;

	/** 发件人已读 */
	private Boolean senderRead;

	/** 收件人已读 */
	private Boolean receiverRead;

	/** 发件人删除 */
	private Boolean senderDelete;

	/** 收件人删除 */
	private Boolean receiverDelete;

	/** 发件人 */
	private Member sender;

	/** 收件人 */
	private Member receiver;

	/** 原消息 */
	private Message forMessage;

	/** 回复消息 */
	private Set<Message> replyMessages = new HashSet<Message>();

	/**
	 * 获取标题
	 * 
	 * @return 标题
	 */
	@Column(nullable = false, updatable = false)
	public String getTitle() {
		return title;
	}

	/**
	 * 设置标题
	 * 
	 * @param title
	 *            标题
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * 获取内容
	 * 
	 * @return 内容
	 */
	@NotEmpty
	@Length(max = 1000)
	@Column(nullable = false, updatable = false, length = 1000)
	public String getContent() {
		return content;
	}

	/**
	 * 设置内容
	 * 
	 * @param content
	 *            内容
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * 获取ip
	 * 
	 * @return ip
	 */
	@Column(nullable = false, updatable = false)
	public String getIp() {
		return ip;
	}

	/**
	 * 设置ip
	 * 
	 * @param ip
	 *            ip
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * 获取是否为草稿
	 * 
	 * @return 是否为草稿
	 */
	@Column(nullable = false, updatable = false)
	public Boolean getIsDraft() {
		return isDraft;
	}

	/**
	 * 设置是否为草稿
	 * 
	 * @param isDraft
	 *            是否为草稿
	 */
	public void setIsDraft(Boolean isDraft) {
		this.isDraft = isDraft;
	}

	/**
	 * 获取发件人已读
	 * 
	 * @return 发件人已读
	 */
	@Column(nullable = false)
	public Boolean getSenderRead() {
		return senderRead;
	}

	/**
	 * 设置发件人已读
	 * 
	 * @param senderRead
	 *            发件人已读
	 */
	public void setSenderRead(Boolean senderRead) {
		this.senderRead = senderRead;
	}

	/**
	 * 获取收件人已读
	 * 
	 * @return 收件人已读
	 */
	@Column(nullable = false)
	public Boolean getReceiverRead() {
		return receiverRead;
	}

	/**
	 * 设置收件人已读
	 * 
	 * @param receiverRead
	 *            收件人已读
	 */
	public void setReceiverRead(Boolean receiverRead) {
		this.receiverRead = receiverRead;
	}

	/**
	 * 获取发件人删除
	 * 
	 * @return 发件人删除
	 */
	@Column(nullable = false)
	public Boolean getSenderDelete() {
		return senderDelete;
	}

	/**
	 * 设置发件人删除
	 * 
	 * @param senderDelete
	 *            发件人删除
	 */
	public void setSenderDelete(Boolean senderDelete) {
		this.senderDelete = senderDelete;
	}

	/**
	 * 获取收件人删除
	 * 
	 * @return 收件人删除
	 */
	@Column(nullable = false)
	public Boolean getReceiverDelete() {
		return receiverDelete;
	}

	/**
	 * 设置收件人删除
	 * 
	 * @param receiverDelete
	 *            收件人删除
	 */
	public void setReceiverDelete(Boolean receiverDelete) {
		this.receiverDelete = receiverDelete;
	}

	/**
	 * 获取发件人
	 * 
	 * @return 发件人
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(updatable = false)
	public Member getSender() {
		return sender;
	}

	/**
	 * 设置发件人
	 * 
	 * @param sender
	 *            发件人
	 */
	public void setSender(Member sender) {
		this.sender = sender;
	}

	/**
	 * 获取收件人
	 * 
	 * @return 收件人
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(updatable = false)
	public Member getReceiver() {
		return receiver;
	}

	/**
	 * 设置收件人
	 * 
	 * @param receiver
	 *            收件人
	 */
	public void setReceiver(Member receiver) {
		this.receiver = receiver;
	}

	/**
	 * 获取原消息
	 * 
	 * @return 原消息
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(updatable = false)
	public Message getForMessage() {
		return forMessage;
	}

	/**
	 * 设置原消息
	 * 
	 * @param forMessage
	 *            原消息
	 */
	public void setForMessage(Message forMessage) {
		this.forMessage = forMessage;
	}

	/**
	 * 获取回复消息
	 * 
	 * @return 回复消息
	 */
	@OneToMany(mappedBy = "forMessage", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy(value = "createDate asc")
	public Set<Message> getReplyMessages() {
		return replyMessages;
	}

	/**
	 * 设置回复消息
	 * 
	 * @param replyMessages
	 *            回复消息
	 */
	public void setReplyMessages(Set<Message> replyMessages) {
		this.replyMessages = replyMessages;
	}

}