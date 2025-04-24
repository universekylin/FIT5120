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
from sqlalchemy import or_, func

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@localhost:3306/db_education'

# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:8uTrTaSJ%26y4gu96cj9LY7%5E@52.63.208.7:3306/mysql_test'

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:wdy531520@localhost:3306/db_education'
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://admin:123456@localhost:3306/db_education2'
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


class SubjectSecondaryCollegeRelation(db.Model):
    __tablename__ = 'db_subject_secondary_college_relation'

    id = Column(Integer, primary_key=True, autoincrement=True)
    subject_id = Column(Integer, ForeignKey('db_subject.id'), nullable=False)
    secondary_college_id = Column(Integer, ForeignKey('db_secondary_college.id'), nullable=False)

    # Relationships using backref like your example
    subject = relationship("Subject", backref="secondary_college_relations")
    secondary_college = relationship("SecondaryCollege", backref="subject_relations")


class Subject(db.Model):
    """
    Represents a subject in the education system
    """
    __tablename__ = 'db_subject'

    id = Column(Integer, primary_key=True, autoincrement=True)
    subject_name = Column(String(255), nullable=False, unique=True)


class SecondaryCollege(db.Model):
    """
    Represents a subject in the education system
    """
    __tablename__ = 'db_secondary_college'

    id = Column(Integer, primary_key=True, autoincrement=True)
    secondary_college_name = Column(String(255), nullable=False, unique=True)


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


@app.route('/api/secondary_colleges', methods=['GET'])
def search_secondary_colleges():
    # Retrieve the search keyword from the query parameters
    keyword = request.args.get('college_name', '').strip()
    # If no keyword is provided, return an error response
    if not keyword:
        return jsonify({'error': 'Search college name is required'}), 400

    try:
        # Perform a fuzzy (case-insensitive) search on the secondary_college_name field
        # using SQLAlchemy's ilike() for case-insensitive pattern matching
        colleges = SecondaryCollege.query.filter(
            SecondaryCollege.secondary_college_name.ilike(f'%{keyword}%')
        ).all()
        result = []
        # Iterate over all the matching secondary colleges
        for college in colleges:
            # Query the relationship table to get all subject relations for this college
            relations = SubjectSecondaryCollegeRelation.query.filter_by(
                secondary_college_id=college.id
            ).all()
            # Extract all related subject IDs from the relation entries
            subject_ids = [rel.subject_id for rel in relations]
            # Query the Subject table to get subject details using the extracted IDs
            subjects = Subject.query.filter(Subject.id.in_(subject_ids)).all()
            # Construct the college data with its related subjects
            result.append({
                'id': college.id,
                'name': college.secondary_college_name,  # Assuming there's a name field
                'subjects': [{
                    'id': sub.id,
                    'name': sub.subject_name
                } for sub in subjects]
            })
        # Return the final result as JSON
        return jsonify({'data': result}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/api/subject', methods=['GET'])
def get_colleges_by_subject():
    # Retrieve the 'subject_name' from the query parameters, removing leading/trailing whitespace
    subject_name = request.args.get('subject_name', '').strip()
    # If no subject name is provided, return a 400 Bad Request response
    if not subject_name:
        return jsonify({'error': 'Subject Name parameter is required'}), 400

    try:
        # Perform a case-insensitive fuzzy search on the subject name
        # Using SQLAlchemy's func.lower() to compare lowercase versions of both values
        matching_subjects = Subject.query.filter(
            func.lower(Subject.subject_name).contains(func.lower(subject_name))
        ).all()
        # If no subjects matched, return a 404 Not Found response
        if not matching_subjects:
            return jsonify({'message': f'No subjects found matching "{subject_name}"'}), 404

        result = []
        # Iterate over each matched subject
        for subject in matching_subjects:
            # Get all colleges that offer this subject
            # Get all entries from the relation table linking this subject to secondary colleges
            relations = SubjectSecondaryCollegeRelation.query.filter_by(
                subject_id=subject.id
            ).all()

            # If there are no relations,
            # skip this subject (no associated colleges)
            if not relations:
                continue
            # Extract the IDs of all related secondary colleges
            college_ids = [rel.secondary_college_id for rel in relations]
            # Query the SecondaryCollege table using the extracted college IDs
            colleges = SecondaryCollege.query.filter(
                SecondaryCollege.id.in_(college_ids)
            ).all()
            # Construct the subject information along with associated colleges
            subject_data = {
                'subject_id': subject.id,
                'subject_name': subject.subject_name,
                'secondaryColleges': [{
                    'college_id': col.id,
                    'college_name': col.secondary_college_name,
                } for col in colleges]
            }
            # Add this subject and its colleges to the result list
            result.append(subject_data)

        # If subjects were matched, but none had associated colleges, return a message
        if not result:
            return jsonify({
                'message': f'Found subjects matching "{subject_name}" but none have associated colleges'
            }), 404
        # Return the successful result as JSON, including the original search term
        return jsonify({
            'search_term': subject_name,
            'results': result
        }), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True, port=5000)
