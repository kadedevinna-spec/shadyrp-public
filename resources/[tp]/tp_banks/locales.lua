Locales = {}


Locales = {

    ['PROMPT_ACTION']                        = "Manage",
    ['PROMPT_VAULT_ACTION']                  = "Open",

    ['BANKING_REGISTRY_TITLE']               = "New Account Cost: $%s Dollars.",
    ['BANKING_REGISTRY_DESCRIPTION']         = "Welcome! Seems like you don't have any Bank Account available, would you like to register?",

    ['BANKING_REGISTRY_ACCEPT_BUTTON']       = "ACCEPT",
    ['BANKING_REGISTRY_DECLINE_BUTTON']      = "DECLINE",
    
    ['INVALID_AMOUNT']                       = "Invalid Amount",
    ['INVALID_IBAN']                         = "Invalid IBAN Account",

    ['DEPOSITED']                            = "DEPOSITED",
    ['WITHDRAWN']                            = "WITHDRAWN",
    ['TRANSFERRED']                          = "TRANSFERRED",
    ['TRANSFERRED_RECEIVER']                 = "RECEIVED",
    ['TAXED_TRANSACTION_HISTORY_RECORD']     = "TAX SUBSCRIPTION",
    ['CREATED_JOINT_ACCOUNT_HISTORY_RECORD'] = "CREATED JOINT ACCOUNT",
    ['RECEIVED_SALARY_HISTORY_RECORD']       = "SALARY RECEIVED",

    ['NOT_ENOUGH_FOR_REGISTRATION']          = "You don't have enough money to register a new banking account.", -- 1.0.1

    ['IBAN_DOES_NOT_EXIST']                  = "The specified IBAN Account does not seem to exist.",

    ['SUCCESS_REGISTRATION']                 = "You have successfully registered and created a new Banking Account.",

    ['INTRA_ACCOUNT_REJECT']                 = "Transfers between accounts within the same bank are not allowed.",
    ['NOT_MIN_ENOUGH_TO_TRANSFER']           = "You cant transfer lower than %s dollars to bank account due to fees.",
    ['NOT_ENOUGH_TRANSFER']                  = "The bank account does not have enough cash to transfer to another bank account.",
    ['TRANSFERRED_TO']                       = "You have transferred %s dollars to an account with the following IBAN. #%s",
    ['BANK_TRANSFERS_DISABLED']              = "You cannot perform this action, the bank transfers are currently disabled.",

    ['NOT_ENOUGH_TO_PAY_BILL']               = "You don't have enough money to pay the bill.",
    ['JOINT_ACCOUNT_ALREADY_EXISTS']         = "You have already a Joint Account, you can't create more than (1).",
    ['NOT_ENOUGH_FOR_JOINT_ACCOUNT']         = "You don't have enough money to create a Joint Account.",

    ['JOINT_ACCOUNT_CREATED']                = "You have created a new Joint Account.",
    ['ALREADY_LOGGED_IN_TO_JOINT_ACCOUNT']   = "You are already logged-in to the specified account.",
    ['JOINT_ACCOUNTS_DISABLED']              = "You cannot perform this action, the joint accounts are currently disabled.",

    ['SUCCESSFULLY_REGISTERED_JOB']          = "You successfully registered your society job.",
    ['ALREADY_REGISTERED_JOB']               = "You have already registered this job.",

    ['SUCCESSFULLY_BOUGHT_VAULT']            = "You successfully bought a vault storage.",
    ['ALREADY_BOUGHT_VAULT']                 = "You have already bought a vault storage.",
    ['VAULT_DISABLED_FEATURE']               = "You are not permitted to buy a vault storage.", -- THIS IS DISPLAYED WHEN tp_containers is disabled from config.

    ['SUCCESSFULLY_RENAMED_JOINT_ACCOUNT']   = "You successfully renamed the Joint Account.",
    ['JOINT_ACCOUNT_MEMBER_EXISTS']          = "The specified IBAN Account already exists as a member on your Joint Banking Account.",
    ['JOINT_ACCOUNT_MEMBER_ADDED']           = "You have successfully added a new account as a member on your Joint Banking Account.",
    ['JOINT_ACCOUNT_MEMBER_DELETED']         = "You have successfully removed a member from your Joint Banking Account.",
    ['JOINT_ACCOUNT_SAME_IBAN']              = "You can't add the same Bank Account as a member.",
    ['JOINT_ACCOUNT_SAME_PERSON']            = "You can't add your primary bank account as a member of a Joint Account that you own!",
    ['JOINT_ACCOUNT_JOINT_MEMBER']           = "You can't add as a member a Joint IBAN Account.",

    ['START_ROBBERY']                        = "~e~Shoot To Start Robbery",
    ['ROBBERY_AWAIT_FOR_ACTIONS']            = "You have to wait %s seconds before performing any actions.",
    ['ROBBERY_CANCEL_DURATION']              = "~e~You are too far! You have %s seconds to cancel the robbery.",

    ['NOT_ENOUGH_PERMISSIONS']               = "~e~Not enough permissions to perform this command.",
    ['IBAN_DURATION_RESET_SUCCESS']          = "The specified IBAN duration has been reset successfully.",

    ['ROBBERY_NOT_ENOUGH_ITEM_QUANTITY']     = "~e~You don't have any %s",
    ['ROBBERY_WAIT_FOR_ACTIONS']             = "~e~You have to wait for the cooldown to finish.",
    ['ROBBERY_VAULT_ATTEMPT_FAILED']         = "~e~Action attempt was a failure, try again.",

    ['ROBBERY_VAULT_RECEIVED']               = "Received %s",
    ['AND']                                  = "and",

    ['NO_VAULT_AVAILABLE']                   = "~e~You don't have any vault.",
    ['NO_BANK_ACCOUNT']                      = "~e~You don't have a bank account available.",

    ['NOT_ENOUGH_PERMISSIONS']               = "You don't have enough permissions to perform this action.", -- 1.0.4
    
    ['MEMBER_PERMISSIONS_DEPOSIT_TEXT']      = "Deposits - Allow this member to deposit money to this account.", -- 1.0.4
    ['MEMBER_PERMISSIONS_WITHDRAWALS_TEXT']  = "Withdrawals - Allow this member to withdraw money from this account.", -- 1.0.4
    ['MEMBER_PERMISSIONS_TRANSFERS_TEXT']    = "Account Transfers - Allow this member to transfer money from this account to others.", -- 1.0.4
    ['MEMBER_PERMISSIONS_BILLING_TEXT']      = "Billing Payments - Allow this member to pay any unpaid bills.", -- 1.0.4


    ['CASH'] = {
        ['CURRENCY']                     = "Dollars",
        ['NOT_ENOUGH_DEPOSIT']           = "The cash you've presented is insufficient for the deposit",
        ['NOT_ENOUGH_WITHDRAW']          = "The bank account has insufficient funds for the withdrawal.",
        ['DEPOSITED']                    = "A total of %s dollars has been deposited into the bank account.",
        ['WITHDRAWN']                    = "A total of %s dollars has been withdrawn from the bank account.",

        ['NOT_REACHING_MIN_ENOUGH']      = "You cant deposit lower than %s dollars to a bank account.",
    },

    
    ['GOLD'] = {
        ['CURRENCY']                     = "Gold",
        ['NOT_ENOUGH_DEPOSIT']           = "The gold you've presented is insufficient for the deposit.",
        ['NOT_ENOUGH_WITHDRAW']          = "The bank account has insufficient funds for the withdrawal.",
        ['DEPOSITED']                    = "A total of %s gold has been deposited into the bank account.",
        ['WITHDRAWN']                    = "A total of %s gold has been withdrawn from the bank account.",
    },

    ['SALARY_RECEIVED'] = {
        title = "Banking", 
        message = "You have received a salary from your work, checkout your bank account.",
        icon = "banking",
        duration = 8
    },

    ['BANK_ALREADY_ROBBED'] = {
        title = "Banking", 
        message = "The specified bank cannot be robbed, it seems that is has already been robbed recently.",
        icon = "banking",
        duration = 6
    },

    ['BANK_NOT_PERMITTED_DAY'] = {
        title = "Banking", 
        message = "The specified bank cannot be robbed today.",
        icon = "banking",
        duration = 6
    },

    ['BANK_CANNOT_BE_ROBBED_BY_POLICE'] = {
        title = "Banking", 
        message = "You are not authorized to perform a robbery, your job gives you away.",
        icon = "banking",
        duration = 6
    },

    ['BANK_NOT_ENOUGH_POLICE'] = {
        title = "Banking", 
        message = "There is not enough police to perform a robbery.",
        icon = "banking",
        duration = 6
    },

    ['BANK_ROBBERY_STARTED'] = {
        title = "Banking", 
        message = "Robbery has started and the police has been alerted! You have %s minute-s remaining before starting any actions.",
        icon = "banking",
        duration = 15,
    },

    ['BANK_ROBBERY_STARTED_ALERT'] = {
        title = "Banking", 
        message = "Robbery has started at %s. Hurry up !", -- %s returns the bank name.
        icon = "banking",
        duration = 30,
    },

    ['BANK_ROBBERY_CANCELLED'] = {
        title = "Banking", 
        message = "The Robbery has been cancelled.",
        icon = "banking",
        duration = 10,
    },

}