export default class Task {
    constructor(id, title, description, status, type, progress, targetAmount){
        this.i_id = id;
        this.s_title = title;
        this.s_description = description;
        this.i_status = status;
        this.i_type = type;
        this.i_progress = progress || 0;
        this.i_targetAmount = targetAmount || 1;
    }
}