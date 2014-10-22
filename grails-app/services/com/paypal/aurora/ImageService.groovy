package com.paypal.aurora

import com.paypal.aurora.model.Image
import com.paypal.aurora.model.SnapshotProperties
import org.apache.shiro.SecurityUtils

class ImageService {

    private static final String IMAGES = 'images'

    private static final String X_META_IMAGE = 'X-Image-Meta'

    private static final List RESTRICTED_IMAGE_TYPES = ['aki', 'ari'] //only admins have access to these types

    def openStackRESTService

    private def getAllImagesOrSnapshots(def type) {
        def resp = openStackRESTService.get(openStackRESTService.GLANCE, "${IMAGES}")
        def images = []
        for (im in resp.images) {
            def image = new Image(im)
            def allowed = SecurityUtils.subject?.hasRole(Constant.ROLE_ADMIN) || !(image.diskFormat in RESTRICTED_IMAGE_TYPES)
            if (allowed && image.type == type) {
                images << image
            }
        }
        images.sort { it.name }
    }

    def getAllImages() {
        getAllImagesOrSnapshots("image")
    }

    def getAllInstanceSnapshots() {
        getAllImagesOrSnapshots("snapshot")
    }

    def getImageById(def imageId) {
        def headers = openStackRESTService.get(openStackRESTService.GLANCE, "${IMAGES}/${imageId}")
        createImageFromHeaders(headers)
    }

    def createImage(def params) {
        def tokens = ["${X_META_IMAGE}-name": params.name, "${X_META_IMAGE}-is_public": params.shared == 'on', "${X_META_IMAGE}-container_format": 'bare',"${X_META_IMAGE}-min_disk":params.minDisk,
                        "${X_META_IMAGE}-min_ram":params.minRam,"${X_META_IMAGE}-disk_format":params.diskFormat]

        def postResponse = openStackRESTService.post(openStackRESTService.GLANCE, "${IMAGES}", null, tokens)

        def putResponse
        if (postResponse){
            putResponse = openStackRESTService.put(openStackRESTService.GLANCE, "${IMAGES}/${postResponse.image.id}", ['x-glance-api-copy-from': params.location])
        }
        new Image(putResponse.image)
    }

    def updateImage(def params) {
        def tokens = ["${X_META_IMAGE}-name": params.name, "${X_META_IMAGE}-is_public": params.shared == 'on', 'x-glance-registry-purge-props': false]
        openStackRESTService.put(openStackRESTService.GLANCE, "${IMAGES}/${params.id}", tokens)
    }

    def deleteImageById(def imageId) {
        openStackRESTService.delete(openStackRESTService.NOVA, "${IMAGES}/${imageId}")
    }

    boolean exists(String imageName) {
        for (Image image : allImages) {
            if(image.name.equals(imageName)) {
                return true
            }
        }
        return false
    }

    private static def createImageFromHeaders(def imageResponse) {
        Image image = new Image(imageResponse)
        SnapshotProperties snapshotProperties = new SnapshotProperties()

    
        image
    }

}
