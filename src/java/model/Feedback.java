package model;

import java.sql.Timestamp;

public class Feedback {
    private int feedbackId;
    private int accountId;
    private String accountName;
    private int rate;
    private String comment;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Feedback() {
    }

    public Feedback(int feedbackId, int accountId, String accountName, int rate, String comment, Timestamp createdAt, Timestamp updatedAt) {
        this.feedbackId = feedbackId;
        this.accountId = accountId;
        this.accountName = accountName;
        this.rate = rate;
        this.comment = comment;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
} 