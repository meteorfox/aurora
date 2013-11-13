package com.paypal.aurora.model

class AvailabilityZone {
    String name
    boolean available

    AvailabilityZone() {
    }

    AvailabilityZone(String name) {
        this.name = name
    }

    AvailabilityZone(def zone) {
        this.name = zone.zoneName
        this.available = zone.zoneState.available
    }

    boolean equals(o) {
        if (this.is(o)) return true
        if (getClass() != o.class) return false

        AvailabilityZone that = (AvailabilityZone) o

        if (available != that.available) return false
        if (name != that.name) return false

        return true
    }

    int hashCode() {
        int result
        result = (name != null ? name.hashCode() : 0)
        result = 31 * result + (available ? 1 : 0)
        return result
    }

    @Override
    public String toString() {
        return "AvailabilityZone{" +
                "name='" + name + '\'' +
                ", available=" + available +
                '}'
    }
}
