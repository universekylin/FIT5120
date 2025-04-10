import json

from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
import pymysql
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import joinedload

app = Flask(__name__)
CORS(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:wdy531520@localhost:3306/db_education'
# mysql+pymysql://root:wdy531520@localhost:3306/db_education
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


class Uni(db.Model):
    __tablename__ = 'db_uni'
    id = Column(Integer, primary_key=True)
    uni_name = Column(String(255), unique=True, nullable=False)


class Major(db.Model):
    __tablename__ = 'db_major'
    id = Column(Integer, primary_key=True)
    major_name = Column(String(200), nullable=False)
    course_code = Column(String(200), unique=True, nullable=False)


class UniMajor(db.Model):
    __tablename__ = 'db_uni_major'
    id = Column(Integer, primary_key=True, autoincrement=True)
    uni_id = Column(Integer, ForeignKey('db_uni.id'), nullable=False)
    major_id = Column(Integer, ForeignKey('db_major.id'), nullable=False)
    duration = Column(String(255))
    atar = Column(String(255))
    subjects = Column(String(255), nullable=False)

    uni = relationship("Uni", backref="uni_majors")
    major = relationship("Major", backref="uni_majors")


class Career(db.Model):
    __tablename__ = 'db_career'
    id = Column(Integer, primary_key=True)
    career_name = Column(String(255), unique=True, nullable=False)


class MajorCareersRelation(db.Model):
    __tablename__ = 'major_careers_relation'
    id = Column(Integer, primary_key=True, autoincrement=True)
    uni_major_id = Column(Integer, ForeignKey('db_uni_major.id'), nullable=False)
    career_id = Column(Integer, ForeignKey('db_career.id'), nullable=False)
    career = relationship("Career", backref="major_relations")
    uni_major = relationship("UniMajor", backref="career_relations")


class JobCareerRelation(db.Model):
    __tablename__ = 'job_career_relation'

    id = Column(Integer, primary_key=True, autoincrement=True)
    job_id = Column(Integer, ForeignKey('db_job_type.id'), nullable=False)
    career_id = Column(Integer, ForeignKey('db_career.id'), nullable=False)

    career = relationship(
        "Career",
        backref="job_relations"  
    )

class JobType(db.Model):
    __tablename__ = 'db_job_type'

    id = Column(Integer, primary_key=True, autoincrement=True)
    job_name = Column(String(255), nullable=False, unique=True)

    career_relations = relationship(
        "JobCareerRelation",
        backref="job_type"  
    )

@app.route('/api/getUniInfo', methods=['GET'])
def get_uni_info():
    career_names = request.args.get('career_names', '')
    type = request.args.get('type', '')

    if type == "job":
        if not career_names:
            return jsonify({'error': 'No career names provided'}), 400
        names_list = [name.strip() for name in career_names.split(',') if name.strip()]
        if not names_list:
            return jsonify({'error': 'No valid career names provided'}), 400
        try:
            careers = get_careers_by_job(names_list)
            if len(careers) == 0:
                return jsonify([]), 200
            # get ids
            career_ids = [career["career_id"] for career in careers]
            results = db.session.query(
                MajorCareersRelation,
                Career,
                UniMajor
            ).join(
                Career,
                MajorCareersRelation.career_id == Career.id,
            ).join(
                UniMajor,
                MajorCareersRelation.uni_major_id == UniMajor.id
            ).filter(
                MajorCareersRelation.career_id.in_(career_ids)
            ).all()
            response = []
            for relation, career, uniMajor in results:
                response.append({
                    "career_id": career.id,
                    "uni_major_id": relation.uni_major_id,
                    "career": {
                        "id": career.id,
                        "career_name": career.career_name,
                    },
                    "uni_major": {
                        "id": uniMajor.id,
                        "uni_id": uniMajor.uni_id,
                        "major_id": uniMajor.major_id,
                        "major": {
                            "major_name": uniMajor.major.major_name,
                            "course_code": uniMajor.major.course_code,
                        },
                        "duration": uniMajor.duration,
                        "uni_name": uniMajor.uni.uni_name,
                        "atar": uniMajor.atar,
                        "subjects": uniMajor.subjects,
                    }
                })
            return jsonify(response)

        except Exception as e:
            return jsonify({'error': str(e)}), 500
    else:
        if not career_names:
            return jsonify({'error': 'No career names provided'}), 400
        names_list = [name.strip() for name in career_names.split(',') if name.strip()]
        if not names_list:
            return jsonify({'error': 'No valid career names provided'}), 400
        try:
            # Query for exact matches
            careers = get_careers(names_list)
            if len(careers) == 0:
                return jsonify([]), 200
            # get ids
            career_ids = [career["id"] for career in careers]
            results = db.session.query(
                MajorCareersRelation,
                Career,
                UniMajor
            ).join(
                Career,
                MajorCareersRelation.career_id == Career.id,
            ).join(
                UniMajor,
                MajorCareersRelation.uni_major_id == UniMajor.id
            ).filter(
                MajorCareersRelation.career_id.in_(career_ids)
            ).all()
            response = []
            for relation, career, uniMajor in results:
                response.append({
                    "career_id": career.id,
                    "uni_major_id": relation.uni_major_id,
                    "career": {
                        "id": career.id,
                        "career_name": career.career_name,
                    },
                    "uni_major": {
                        "id": uniMajor.id,
                        "uni_id": uniMajor.uni_id,
                        "major_id": uniMajor.major_id,
                        "major": {
                            "major_name": uniMajor.major.major_name,
                            "course_code": uniMajor.major.course_code,
                        },
                        "duration": uniMajor.duration,
                        "uni_name": uniMajor.uni.uni_name,
                        "atar": uniMajor.atar,
                        "subjects": uniMajor.subjects,
                    }
                })
            return jsonify(response)
        except Exception as e:
            return jsonify({'error': str(e)}), 500


# Mental Health Counselor, Nurse, Nutritionist,
def get_careers(names_list):
    try:
        # Query for exact matches
        careers = Career.query.filter(Career.career_name.in_(names_list)).all()
        # Prepare the response
        if careers is None:
            return jsonify([])
        result = [{
            'id': career.id,
            'career_name': career.career_name
        } for career in careers]

        return result

    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500


def get_careers_by_job(names_list):
    try:
        # Query for exact matches
        jobs = JobType.query.filter(JobType.job_name.in_(names_list)).all()
        # Prepare the response

        if jobs is None:
            return jsonify([])
        result = [{
            'id': job.id,
            'job_name': job.job_name
        } for job in jobs]

        job_ids = [job["id"] for job in result]
        relations = db.session.query(JobCareerRelation) \
            .filter(JobCareerRelation.job_id.in_(job_ids)) \
            .all()
        _result = [{
            'job_id': relation.job_id,
            'career_id': relation.career_id
        } for relation in relations]
        return _result

    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500
if __name__ == '__main__':
    app.run(debug=True, port=5000)
