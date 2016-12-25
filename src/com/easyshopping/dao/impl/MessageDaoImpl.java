/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.dao.MessageDao;
import com.easyshopping.entity.Member;
import com.easyshopping.entity.Message;

import org.springframework.stereotype.Repository;

/**
 * Dao - 消息
 * 
 * 
 * @version 1.0
 */
@Repository("messageDaoImpl")
public class MessageDaoImpl extends BaseDaoImpl<Message, Long> implements MessageDao {

	public Page<Message> findPage(Member member, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Message> criteriaQuery = criteriaBuilder.createQuery(Message.class);
		Root<Message> root = criteriaQuery.from(Message.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.isNull(root.get("forMessage")), criteriaBuilder.equal(root.get("isDraft"), false));
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.equal(root.get("sender"), member), criteriaBuilder.equal(root.get("senderDelete"), false)), criteriaBuilder.and(criteriaBuilder.equal(root.get("receiver"), member), criteriaBuilder.equal(root.get("receiverDelete"), false))));
		} else {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.isNull(root.get("sender")), criteriaBuilder.equal(root.get("senderDelete"), false)), criteriaBuilder.and(criteriaBuilder.isNull(root.get("receiver")), criteriaBuilder.equal(root.get("receiverDelete"), false))));
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);

	}

	public Page<Message> findDraftPage(Member sender, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Message> criteriaQuery = criteriaBuilder.createQuery(Message.class);
		Root<Message> root = criteriaQuery.from(Message.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.isNull(root.get("forMessage")), criteriaBuilder.equal(root.get("isDraft"), true));
		if (sender != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("sender"), sender));
		} else {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.isNull(root.get("sender")));
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

	public Long count(Member member, Boolean read) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Message> criteriaQuery = criteriaBuilder.createQuery(Message.class);
		Root<Message> root = criteriaQuery.from(Message.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.isNull(root.get("forMessage")), criteriaBuilder.equal(root.get("isDraft"), false));
		if (member != null) {
			if (read != null) {
				restrictions = criteriaBuilder.and(
						restrictions,
						criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.equal(root.get("sender"), member), criteriaBuilder.equal(root.get("senderDelete"), false), criteriaBuilder.equal(root.get("senderRead"), read)),
								criteriaBuilder.and(criteriaBuilder.equal(root.get("receiver"), member), criteriaBuilder.equal(root.get("receiverDelete"), false), criteriaBuilder.equal(root.get("receiverRead"), read))));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.equal(root.get("sender"), member), criteriaBuilder.equal(root.get("senderDelete"), false)), criteriaBuilder.and(criteriaBuilder.equal(root.get("receiver"), member), criteriaBuilder.equal(root.get("receiverDelete"), false))));
			}
		} else {
			if (read != null) {
				restrictions = criteriaBuilder.and(restrictions,
						criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.isNull(root.get("sender")), criteriaBuilder.equal(root.get("senderDelete"), false), criteriaBuilder.equal(root.get("senderRead"), read)), criteriaBuilder.and(criteriaBuilder.isNull(root.get("receiver")), criteriaBuilder.equal(root.get("receiverDelete"), false), criteriaBuilder.equal(root.get("receiverRead"), read))));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.and(criteriaBuilder.isNull(root.get("sender")), criteriaBuilder.equal(root.get("senderDelete"), false)), criteriaBuilder.and(criteriaBuilder.isNull(root.get("receiver")), criteriaBuilder.equal(root.get("receiverDelete"), false))));
			}
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}

	public void remove(Long id, Member member) {
		Message message = super.find(id);
		if (message == null || message.getForMessage() != null) {
			return;
		}
		if ((member != null && member.equals(message.getReceiver())) || (member == null && message.getReceiver() == null)) {
			if (!message.getIsDraft()) {
				if (message.getSenderDelete()) {
					super.remove(message);
				} else {
					message.setReceiverDelete(true);
					super.merge(message);
				}
			}
		} else if ((member != null && member.equals(message.getSender())) || (member == null && message.getSender() == null)) {
			if (message.getIsDraft()) {
				super.remove(message);
			} else {
				if (message.getReceiverDelete()) {
					super.remove(message);
				} else {
					message.setSenderDelete(true);
					super.merge(message);
				}
			}
		}
	}

}