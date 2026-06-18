/**
 * Simple wrapper around fetch API tailored for CEF/NUI usage.
 * This abstraction handles the specific URL formatting required by FiveM's NUI system.
 */
export const fetchNui = async (eventName: string, data: any = {}) => {
    const options = {
        method: 'post',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data),
    };

    // Get the resource name dynamically or fallback for dev/browser testing
    const resourceName = (window as any).GetParentResourceName ? (window as any).GetParentResourceName() : 'nui-frame-app';

    try {
        const resp = await fetch(`https://${resourceName}/${eventName}`, options);
        // Sometimes valid NUI callbacks don't return JSON, so we handle that gracefully if needed
        // But standard practice is returning JSON
        const respData = await resp.json();
        return respData;
    } catch (e) {
        // In standard browser environment (outside game), this will fail.
        // We suppress the error or log it as a warning only.
        // console.warn(`NUI Request to ${eventName} failed (likely in browser env).`);
        return null;
    }
};
